from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView

from . import auth_views

urlpatterns = [
    path("needs_setup", auth_views.needs_setup),
    path("setup", auth_views.setup),
    path("login", auth_views.login),
    path("mfa/verify", auth_views.mfa_verify),
    path("register", auth_views.register),
    path("refresh", TokenRefreshView.as_view()),
    path("me", auth_views.me),
    path("change_password", auth_views.change_password),
    path("mfa/setup", auth_views.mfa_setup),
    path("mfa/enable", auth_views.mfa_enable),
    path("mfa/disable", auth_views.mfa_disable),
]
