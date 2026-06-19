from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as DjangoUserAdmin

from .models import AuditLogEntry, Role, User


@admin.register(User)
class UserAdmin(DjangoUserAdmin):
    ordering = ["login"]
    list_display = ["login", "full_name", "role", "is_active", "mfa_enabled"]
    search_fields = ["login", "full_name", "email"]
    fieldsets = (
        (None, {"fields": ("login", "password")}),
        ("Profil", {"fields": ("full_name", "email", "phone", "photo")}),
        ("Rôle & accès", {"fields": ("role", "is_active", "is_staff",
                                     "is_superuser", "must_change_password")}),
        ("MFA", {"fields": ("mfa_enabled", "mfa_secret")}),
    )
    add_fieldsets = (
        (None, {"classes": ("wide",),
                "fields": ("login", "full_name", "role", "password1", "password2")}),
    )


admin.site.register(Role)
admin.site.register(AuditLogEntry)
