from django.contrib.auth.models import (
    AbstractBaseUser,
    BaseUserManager,
    PermissionsMixin,
)
from django.db import models

from .constants import default_role_matrix


class UserManager(BaseUserManager):
    def create_user(self, login, password=None, **extra):
        if not login:
            raise ValueError("Le champ « login » est obligatoire.")
        user = self.model(login=login, **extra)
        if password:
            user.set_password(password)
        else:
            user.set_unusable_password()
        user.save(using=self._db)
        return user

    def create_superuser(self, login, password=None, **extra):
        extra.setdefault("role", "administrateur")
        extra.setdefault("is_staff", True)
        extra.setdefault("is_superuser", True)
        extra.setdefault("full_name", "Administrateur")
        return self.create_user(login, password, **extra)


class User(AbstractBaseUser, PermissionsMixin):
    """Custom user. `login` is the identifier (legacy field name)."""

    login = models.CharField(max_length=120, unique=True)
    full_name = models.CharField(max_length=200, blank=True)
    email = models.EmailField(blank=True)
    phone = models.CharField(max_length=60, blank=True)
    role = models.CharField(max_length=40, default="agent")

    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    must_change_password = models.BooleanField(default=False)

    # MFA (TOTP)
    mfa_enabled = models.BooleanField(default=False)
    mfa_secret = models.CharField(max_length=64, blank=True)

    photo = models.TextField(blank=True)  # data-uri or URL
    created_at = models.DateTimeField(auto_now_add=True)

    objects = UserManager()

    USERNAME_FIELD = "login"
    REQUIRED_FIELDS = []

    def __str__(self):
        return self.login


class Role(models.Model):
    key = models.CharField(max_length=40, unique=True)
    name = models.CharField(max_length=120)
    description = models.CharField(max_length=255, blank=True)
    locked = models.BooleanField(default=False)
    order = models.IntegerField(default=0)
    permissions = models.JSONField(default=dict)  # {module: {view,create,edit,delete}}

    class Meta:
        ordering = ["order"]

    def __str__(self):
        return self.key

    @classmethod
    def ensure_defaults(cls):
        """Create the five built-in roles if missing (idempotent)."""
        from .constants import ROLE_DEFS

        matrix = default_role_matrix()
        for d in ROLE_DEFS:
            cls.objects.get_or_create(
                key=d["key"],
                defaults={
                    "name": d["name"],
                    "description": d["description"],
                    "locked": d["locked"],
                    "order": d["order"],
                    "permissions": matrix.get(d["key"], {}),
                },
            )


class AuditLogEntry(models.Model):
    """Authentication / security journal (legacy `state.authLog`)."""

    action = models.CharField(max_length=200)
    login = models.CharField(max_length=120)
    ts = models.DateTimeField(auto_now_add=True)
    device = models.CharField(max_length=40, blank=True)
    ip = models.GenericIPAddressField(null=True, blank=True)

    class Meta:
        ordering = ["-ts"]


class NotificationRead(models.Model):
    """Tracks which generated notifications a user has read."""

    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="read_notifs")
    notif_id = models.CharField(max_length=160)

    class Meta:
        unique_together = ("user", "notif_id")
