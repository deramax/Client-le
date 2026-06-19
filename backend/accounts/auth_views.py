"""Authentication endpoints: setup, login (+MFA), register, profile, password."""
import pyotp
from django.contrib.auth import authenticate
from django.core import signing
from rest_framework import status
from rest_framework.decorators import (
    api_view,
    authentication_classes,
    permission_classes,
)
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken

from .constants import ROLE_KEYS
from .models import User
from .serializers import UserSerializer
from .utils import log_audit

MFA_SALT = "clientara.mfa"
MFA_MAX_AGE = 300  # 5 minutes to complete the second factor


def _tokens(user):
    refresh = RefreshToken.for_user(user)
    return {"access": str(refresh.access_token), "refresh": str(refresh)}


def _login_payload(user):
    data = {**_tokens(user), "user": UserSerializer(user).data}
    if user.must_change_password:
        data["must_change_password"] = True
    return data


@api_view(["GET"])
@permission_classes([AllowAny])
@authentication_classes([])
def needs_setup(request):
    return Response({"needs_setup": not User.objects.exists()})


@api_view(["POST"])
@permission_classes([AllowAny])
@authentication_classes([])
def setup(request):
    """Create the first administrator (only when no users exist)."""
    if User.objects.exists():
        return Response({"detail": "Un compte existe déjà."}, status=400)
    d = request.data
    name = (d.get("fullName") or "").strip()
    login = (d.get("login") or "").strip()
    pw = d.get("password") or ""
    if not name:
        return Response({"detail": "Le nom complet est obligatoire."}, status=400)
    if len(login) < 3:
        return Response({"detail": "L'identifiant doit comporter au moins 3 caractères."}, status=400)
    if len(pw) < 8:
        return Response({"detail": "Le mot de passe doit comporter au moins 8 caractères."}, status=400)
    user = User.objects.create_user(
        login=login, password=pw, full_name=name,
        role="administrateur", is_staff=True, is_superuser=True,
    )
    log_audit(request, "Création du compte administrateur initial", login)
    return Response({"ok": True, "user": UserSerializer(user).data}, status=201)


@api_view(["POST"])
@permission_classes([AllowAny])
@authentication_classes([])
def login(request):
    login_id = (request.data.get("login") or "").strip()
    pw = request.data.get("password") or ""
    user = authenticate(request, username=login_id, password=pw)
    if user is None or not user.is_active:
        log_audit(request, "Échec de connexion", login_id or "—")
        return Response(
            {"detail": "Identifiant ou mot de passe incorrect."},
            status=status.HTTP_401_UNAUTHORIZED,
        )
    if user.mfa_enabled and user.mfa_secret:
        token = signing.dumps({"uid": user.id}, salt=MFA_SALT)
        log_audit(request, "Connexion — second facteur requis", user.login)
        return Response({"mfa_required": True, "mfa_token": token})
    log_audit(request, "Connexion réussie", user.login)
    return Response(_login_payload(user))


@api_view(["POST"])
@permission_classes([AllowAny])
@authentication_classes([])
def mfa_verify(request):
    token = request.data.get("mfa_token") or ""
    code = (request.data.get("code") or "").strip()
    try:
        data = signing.loads(token, salt=MFA_SALT, max_age=MFA_MAX_AGE)
    except signing.BadSignature:
        return Response({"detail": "Session expirée, reconnectez-vous."}, status=400)
    user = User.objects.filter(id=data.get("uid"), is_active=True).first()
    if not user or not user.mfa_secret:
        return Response({"detail": "Compte introuvable."}, status=400)
    if not pyotp.TOTP(user.mfa_secret).verify(code, valid_window=1):
        log_audit(request, "Échec du second facteur (MFA)", user.login)
        return Response({"detail": "Code de vérification invalide."}, status=400)
    log_audit(request, "Connexion réussie (MFA)", user.login)
    return Response(_login_payload(user))


@api_view(["POST"])
@permission_classes([AllowAny])
@authentication_classes([])
def register(request):
    """Public self-registration (any role except administrateur)."""
    d = request.data
    name = (d.get("fullName") or "").strip()
    login_id = (d.get("login") or "").strip()
    role = d.get("role") or "agent"
    pw = d.get("password") or ""
    if not name:
        return Response({"detail": "Le nom complet est obligatoire."}, status=400)
    if len(login_id) < 3:
        return Response({"detail": "L'identifiant doit comporter au moins 3 caractères."}, status=400)
    if User.objects.filter(login__iexact=login_id).exists():
        return Response({"detail": "Cet identifiant existe déjà."}, status=400)
    if role == "administrateur" or role not in ROLE_KEYS:
        return Response({"detail": "Rôle invalide."}, status=400)
    if len(pw) < 8:
        return Response({"detail": "Le mot de passe doit comporter au moins 8 caractères."}, status=400)
    user = User.objects.create_user(
        login=login_id, password=pw, full_name=name,
        email=(d.get("email") or "").strip(), phone=(d.get("phone") or "").strip(),
        role=role,
    )
    log_audit(request, "Création de compte (auto-inscription)", login_id)
    log_audit(request, "Connexion réussie", login_id)
    return Response(_login_payload(user), status=201)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def me(request):
    return Response(UserSerializer(request.user).data)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def change_password(request):
    pw = request.data.get("password") or ""
    if len(pw) < 8:
        return Response({"detail": "Le mot de passe doit comporter au moins 8 caractères."}, status=400)
    user = request.user
    user.set_password(pw)
    user.must_change_password = False
    user.save(update_fields=["password", "must_change_password"])
    log_audit(request, "Changement de mot de passe", user.login)
    return Response({"ok": True})


# ---- MFA enrolment -------------------------------------------------------
@api_view(["POST"])
@permission_classes([IsAuthenticated])
def mfa_setup(request):
    user = request.user
    secret = pyotp.random_base32()
    user.mfa_secret = secret  # stored but not yet "enabled" until verified
    user.save(update_fields=["mfa_secret"])
    uri = pyotp.TOTP(secret).provisioning_uri(name=user.login, issuer_name="ClienTara")
    return Response({"secret": secret, "otpauth_url": uri})


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def mfa_enable(request):
    user = request.user
    code = (request.data.get("code") or "").strip()
    if not user.mfa_secret:
        return Response({"detail": "Initialisez d'abord le MFA."}, status=400)
    if not pyotp.TOTP(user.mfa_secret).verify(code, valid_window=1):
        return Response({"detail": "Code invalide."}, status=400)
    user.mfa_enabled = True
    user.save(update_fields=["mfa_enabled"])
    log_audit(request, "Activation du MFA", user.login)
    return Response({"ok": True})


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def mfa_disable(request):
    user = request.user
    user.mfa_enabled = False
    user.mfa_secret = ""
    user.save(update_fields=["mfa_enabled", "mfa_secret"])
    log_audit(request, "Désactivation du MFA", user.login)
    return Response({"ok": True})
