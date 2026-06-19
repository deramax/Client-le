"""
Django settings for the ClienTara backend.

Configuration is driven by environment variables so the same image runs
locally (SQLite / Postgres) and in production. See `.env.example` at the repo
root for the full list.
"""
import os
from datetime import timedelta
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent


def env(key, default=None):
    return os.environ.get(key, default)


def env_bool(key, default=False):
    val = os.environ.get(key)
    if val is None:
        return default
    return val.strip().lower() in ("1", "true", "yes", "on")


def env_list(key, default=""):
    raw = os.environ.get(key, default) or ""
    return [item.strip() for item in raw.split(",") if item.strip()]


# --------------------------------------------------------------------------
# Core
# --------------------------------------------------------------------------
SECRET_KEY = env("DJANGO_SECRET_KEY", "dev-insecure-change-me")
DEBUG = env_bool("DJANGO_DEBUG", True)
ALLOWED_HOSTS = env_list("DJANGO_ALLOWED_HOSTS", "*") or ["*"]

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    # third-party
    "rest_framework",
    "corsheaders",
    "django_filters",
    # local
    "accounts",
    "core",
    "fourd",
]

MIDDLEWARE = [
    "corsheaders.middleware.CorsMiddleware",
    "django.middleware.security.SecurityMiddleware",
    "whitenoise.middleware.WhiteNoiseMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]

ROOT_URLCONF = "clientara.urls"

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    },
]

WSGI_APPLICATION = "clientara.wsgi.application"
ASGI_APPLICATION = "clientara.asgi.application"

# --------------------------------------------------------------------------
# Database — Postgres when DB_HOST is set, else SQLite (zero-config local dev)
# --------------------------------------------------------------------------
if env("DB_HOST"):
    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.postgresql",
            "NAME": env("DB_NAME", "clientara"),
            "USER": env("DB_USER", "clientara"),
            "PASSWORD": env("DB_PASSWORD", "clientara"),
            "HOST": env("DB_HOST", "db"),
            "PORT": env("DB_PORT", "5432"),
        }
    }
else:
    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.sqlite3",
            "NAME": BASE_DIR / "db.sqlite3",
        }
    }

# --------------------------------------------------------------------------
# Auth
# --------------------------------------------------------------------------
AUTH_USER_MODEL = "accounts.User"

AUTH_PASSWORD_VALIDATORS = [
    {"NAME": "django.contrib.auth.password_validation.MinimumLengthValidator",
     "OPTIONS": {"min_length": 8}},
]

# Authentication backends — LDAP first (if enabled), then the local DB backend.
AUTHENTICATION_BACKENDS = ["django.contrib.auth.backends.ModelBackend"]

LANGUAGE_CODE = "fr-fr"
TIME_ZONE = env("TIME_ZONE", "Indian/Antananarivo")
USE_I18N = True
USE_TZ = True

STATIC_URL = "static/"
STATIC_ROOT = BASE_DIR / "staticfiles"
STATICFILES_STORAGE = "whitenoise.storage.CompressedManifestStaticFilesStorage"

DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"

# --------------------------------------------------------------------------
# DRF + JWT
# --------------------------------------------------------------------------
REST_FRAMEWORK = {
    "DEFAULT_AUTHENTICATION_CLASSES": (
        "rest_framework_simplejwt.authentication.JWTAuthentication",
    ),
    "DEFAULT_PERMISSION_CLASSES": (
        "rest_framework.permissions.IsAuthenticated",
    ),
    "DEFAULT_FILTER_BACKENDS": (
        "django_filters.rest_framework.DjangoFilterBackend",
        "rest_framework.filters.SearchFilter",
    ),
    # Decimal amounts are returned as JSON numbers (the React app calls Number()).
    "COERCE_DECIMAL_TO_STRING": False,
    "DEFAULT_RENDERER_CLASSES": ("rest_framework.renderers.JSONRenderer",),
}

SIMPLE_JWT = {
    "ACCESS_TOKEN_LIFETIME": timedelta(minutes=int(env("JWT_ACCESS_MIN", "120"))),
    "REFRESH_TOKEN_LIFETIME": timedelta(days=int(env("JWT_REFRESH_DAYS", "7"))),
    "AUTH_HEADER_TYPES": ("Bearer",),
    "USER_ID_FIELD": "id",
    "USER_ID_CLAIM": "user_id",
}

# --------------------------------------------------------------------------
# CORS
# --------------------------------------------------------------------------
CORS_ALLOW_ALL_ORIGINS = env_bool("CORS_ALLOW_ALL", True)
CORS_ALLOWED_ORIGINS = env_list("CORS_ALLOWED_ORIGINS")
CORS_ALLOW_HEADERS = ["authorization", "content-type", "x-api-token"]

# --------------------------------------------------------------------------
# 4D / data source  (consumed by the `fourd` app — see fourd/connector.py)
# --------------------------------------------------------------------------
DATA_SOURCE = (env("DATA_SOURCE", "demo") or "demo").lower()  # demo | production
FOURD_URL = (env("FOURD_URL", "") or "").rstrip("/")
FOURD_USER = env("FOURD_USER", "")
FOURD_PASSWORD = env("FOURD_PASSWORD", "")
FOURD_TIMEOUT = int(env("FOURD_TIMEOUT", "10000")) / 1000.0
API_TOKEN = env("API_TOKEN", "")  # optional shared secret for the /fourd portal

# --------------------------------------------------------------------------
# LDAP (⚠️ requires a real directory + python-ldap; disabled by default).
# When LDAP_ENABLED=true and django-auth-ldap is installed, the LDAP backend is
# prepended so users authenticate against the directory. Full notes are in
# accounts/ldap_config.py and the root README.
# --------------------------------------------------------------------------
LDAP_ENABLED = env_bool("LDAP_ENABLED", False)
if LDAP_ENABLED:
    try:
        from accounts.ldap_config import configure_ldap

        configure_ldap(globals(), env, env_bool)
    except Exception as exc:  # pragma: no cover - infra dependent
        import sys

        print(f"[ClienTara] LDAP requested but not configured: {exc}", file=sys.stderr)
