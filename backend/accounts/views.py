"""Admin-facing account, role and audit-journal endpoints."""
from rest_framework import viewsets
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from .models import AuditLogEntry, Role, User
from .permissions import ModulePermission, can
from .serializers import (
    AccountWriteSerializer,
    AuditLogSerializer,
    RoleSerializer,
    UserSerializer,
)


class AccountViewSet(viewsets.ModelViewSet):
    """User management — gated by the `parametres` module."""

    queryset = User.objects.all().order_by("login")
    permission_classes = [IsAuthenticated, ModulePermission]
    module = "parametres"
    pagination_class = None

    def get_serializer_class(self):
        if self.action in ("list", "retrieve"):
            return UserSerializer
        return AccountWriteSerializer


class RoleViewSet(viewsets.ModelViewSet):
    queryset = Role.objects.all()
    serializer_class = RoleSerializer
    permission_classes = [IsAuthenticated, ModulePermission]
    module = "parametres"
    pagination_class = None
    lookup_field = "key"

    def perform_update(self, serializer):
        # The administrator role matrix is locked (always full access).
        if serializer.instance.locked:
            return
        serializer.save()


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def audit_journal(request):
    if not can(request.user, "journal", "view"):
        return Response({"detail": "Accès refusé."}, status=403)
    qs = AuditLogEntry.objects.all()[:500]
    return Response(AuditLogSerializer(qs, many=True).data)
