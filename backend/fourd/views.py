from django.conf import settings
from rest_framework.decorators import (
    api_view,
    authentication_classes,
    permission_classes,
)
from rest_framework.permissions import BasePermission
from rest_framework.response import Response

from .connector import get_connector, mapping


class FourdAccess(BasePermission):
    """Allow an authenticated app user, or a caller presenting a valid
    x-api-token when API_TOKEN is configured (external integrators)."""

    message = "Authentification requise."

    def has_permission(self, request, view):
        if getattr(request, "user", None) and request.user.is_authenticated:
            return True
        token = settings.API_TOKEN
        return bool(token) and request.headers.get("x-api-token") == token


@api_view(["GET"])
@permission_classes([FourdAccess])
def health(request):
    out = get_connector().health()
    out["dataSource"] = settings.DATA_SOURCE
    return Response(out)


@api_view(["GET"])
@permission_classes([FourdAccess])
def config(request):
    return Response({
        "mode": settings.DATA_SOURCE,
        "fourdUrl": settings.FOURD_URL or None if settings.DATA_SOURCE == "production" else None,
        "mapping": mapping(),
    })


@api_view(["GET"])
@permission_classes([FourdAccess])
def search(request):
    q = request.query_params.get("q", "")
    try:
        results = get_connector().search(q)
    except Exception as exc:  # pragma: no cover - depends on live 4D
        return Response({"error": "Recherche impossible", "detail": str(exc),
                         "mode": settings.DATA_SOURCE}, status=502)
    return Response({"mode": settings.DATA_SOURCE, "count": len(results), "results": results})


@api_view(["GET"])
@permission_classes([FourdAccess])
def dossier(request, refnum):
    try:
        d = get_connector().dossier(refnum)
    except Exception as exc:  # pragma: no cover - depends on live 4D
        return Response({"error": "Lecture impossible", "detail": str(exc),
                         "mode": settings.DATA_SOURCE}, status=502)
    if not d:
        return Response({"found": False, "error": "Client introuvable", "refnum": refnum}, status=404)
    return Response({"found": True, "mode": settings.DATA_SOURCE, **d})
