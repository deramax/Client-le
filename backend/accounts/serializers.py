from rest_framework import serializers

from .constants import ROLE_KEYS
from .models import AuditLogEntry, Role, User
from .permissions import effective_permissions


class UserSerializer(serializers.ModelSerializer):
    """Read shape consumed by the React app."""

    fullName = serializers.CharField(source="full_name", required=False, allow_blank=True)
    roleName = serializers.SerializerMethodField()
    active = serializers.BooleanField(source="is_active", required=False)
    permissions = serializers.SerializerMethodField()

    class Meta:
        model = User
        fields = [
            "id", "login", "fullName", "email", "phone", "role", "roleName",
            "active", "must_change_password", "mfa_enabled", "photo", "permissions",
        ]

    def get_roleName(self, obj):
        try:
            return Role.objects.get(key=obj.role).name
        except Role.DoesNotExist:
            return obj.role

    def get_permissions(self, obj):
        return effective_permissions(obj.role)


class AccountWriteSerializer(serializers.ModelSerializer):
    """Admin user management (create / update accounts)."""

    fullName = serializers.CharField(source="full_name", required=False, allow_blank=True)
    active = serializers.BooleanField(source="is_active", required=False)
    password = serializers.CharField(write_only=True, required=False, allow_blank=True)

    class Meta:
        model = User
        fields = [
            "id", "login", "fullName", "email", "phone", "role",
            "active", "must_change_password", "password",
        ]

    def validate_role(self, value):
        if value not in ROLE_KEYS:
            raise serializers.ValidationError("Rôle invalide.")
        return value

    def create(self, validated):
        password = validated.pop("password", "") or None
        user = User(**validated)
        if password:
            user.set_password(password)
        else:
            user.set_unusable_password()
        user.save()
        return user

    def update(self, instance, validated):
        password = validated.pop("password", None)
        for k, v in validated.items():
            setattr(instance, k, v)
        if password:
            instance.set_password(password)
            instance.must_change_password = False
        instance.save()
        return instance


class RoleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Role
        fields = ["key", "name", "description", "locked", "order", "permissions"]
        read_only_fields = ["key", "locked"]


class AuditLogSerializer(serializers.ModelSerializer):
    ts = serializers.SerializerMethodField()

    class Meta:
        model = AuditLogEntry
        fields = ["action", "login", "ts", "device", "ip"]

    def get_ts(self, obj):
        return obj.ts.isoformat()
