"""
LDAP authentication wiring (⚠️ requires a real directory + python-ldap).

This is intentionally isolated from settings.py so the rest of the stack builds
and runs locally without python-ldap installed. It is activated only when
`LDAP_ENABLED=true` *and* `django-auth-ldap` is importable (installed via
requirements-ldap.txt in the Docker image).

What it does when enabled
-------------------------
* Prepends `django_auth_ldap.backend.LDAPBackend` to AUTHENTICATION_BACKENDS so
  `authenticate()` (used by the /api/auth/login view) first tries the directory,
  then falls back to the local Django password backend.
* Maps LDAP attributes -> our User model fields (full_name, email, phone).
* Optionally maps an LDAP group to the `administrateur` role.

MFA still applies on top of LDAP: a user with `mfa_enabled=True` is challenged
for a TOTP code after the directory accepts the password.

Local development
-----------------
The bundled docker-compose ships an `openldap` service (profile `ldap`) seeded
from `ldap/seed.ldif` so you can exercise this path locally:

    docker compose --profile ldap up

Then set LDAP_ENABLED=true and the LDAP_* vars below. See the root README.
"""


def configure_ldap(settings_globals, env, env_bool):
    import ldap  # noqa: F401  (python-ldap; only imported when LDAP is enabled)
    from django_auth_ldap.config import GroupOfNamesType, LDAPSearch

    g = settings_globals

    g["AUTH_LDAP_SERVER_URI"] = env("LDAP_SERVER_URI", "ldap://openldap:389")
    g["AUTH_LDAP_BIND_DN"] = env("LDAP_BIND_DN", "cn=admin,dc=clientara,dc=local")
    g["AUTH_LDAP_BIND_PASSWORD"] = env("LDAP_BIND_PASSWORD", "admin")

    user_base = env("LDAP_USER_BASE", "ou=people,dc=clientara,dc=local")
    user_filter = env("LDAP_USER_FILTER", "(uid=%(user)s)")
    g["AUTH_LDAP_USER_SEARCH"] = LDAPSearch(
        user_base, ldap.SCOPE_SUBTREE, user_filter
    )

    # LDAP attr -> User model field
    g["AUTH_LDAP_USER_ATTR_MAP"] = {
        "full_name": env("LDAP_ATTR_FULLNAME", "cn"),
        "email": env("LDAP_ATTR_EMAIL", "mail"),
        "phone": env("LDAP_ATTR_PHONE", "telephoneNumber"),
    }

    # Create/refresh the local User row on each successful LDAP login.
    g["AUTH_LDAP_ALWAYS_UPDATE_USER"] = True

    # Optional: map a directory group to the administrator role.
    group_base = env("LDAP_GROUP_BASE", "")
    if group_base:
        g["AUTH_LDAP_GROUP_SEARCH"] = LDAPSearch(
            group_base, ldap.SCOPE_SUBTREE, "(objectClass=groupOfNames)"
        )
        g["AUTH_LDAP_GROUP_TYPE"] = GroupOfNamesType()
        admin_group = env("LDAP_ADMIN_GROUP", "")
        if admin_group:
            g["AUTH_LDAP_USER_FLAGS_BY_GROUP"] = {
                "is_staff": admin_group,
                "is_superuser": admin_group,
            }

    backends = list(g.get("AUTHENTICATION_BACKENDS", []))
    ldap_backend = "django_auth_ldap.backend.LDAPBackend"
    if ldap_backend not in backends:
        backends.insert(0, ldap_backend)
    g["AUTHENTICATION_BACKENDS"] = backends
