"""Module-level RBAC, mirroring canView/can() from the legacy app."""
from rest_framework.permissions import BasePermission

from .constants import CAPS, MODULES
from .models import Role

_METHOD_CAP = {
    "GET": "view", "HEAD": "view", "OPTIONS": "view",
    "POST": "create", "PUT": "edit", "PATCH": "edit", "DELETE": "delete",
}


def effective_permissions(role_key):
    """Full perms for admin; otherwise the role's stored matrix."""
    if role_key == "administrateur":
        return {m: {c: True for c in CAPS} for m in MODULES}
    try:
        return Role.objects.get(key=role_key).permissions or {}
    except Role.DoesNotExist:
        return {}


def can(user, module, cap):
    if not user or not getattr(user, "is_authenticated", False):
        return False
    if getattr(user, "role", None) == "administrateur":
        return True
    perms = effective_permissions(user.role)
    return bool((perms.get(module) or {}).get(cap))


class ModulePermission(BasePermission):
    """Attach `module = "<key>"` to a view to gate it by the RBAC matrix."""

    message = "Accès refusé — droits insuffisants pour ce module."

    def has_permission(self, request, view):
        module = getattr(view, "module", None)
        if module is None:
            return True
        cap = _METHOD_CAP.get(request.method, "view")
        return can(request.user, module, cap)
