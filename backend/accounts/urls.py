from django.urls import path
from rest_framework.routers import DefaultRouter

from . import views

router = DefaultRouter()
router.register("users", views.AccountViewSet, basename="users")
router.register("roles", views.RoleViewSet, basename="roles")

urlpatterns = [
    path("journal/", views.audit_journal),
] + router.urls
