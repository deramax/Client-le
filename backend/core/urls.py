from django.urls import path
from rest_framework.routers import DefaultRouter

from accounts.views import audit_journal

from . import views

router = DefaultRouter()
router.register("demandes", views.DemandeViewSet, basename="demandes")

urlpatterns = [
    path("clients/", views.clients),
    path("referentiels/", views.referentiels),
    path("kpis/", views.dashboard_kpis),
    path("rapports/", views.rapports),
    path("notifications/", views.notifications),
    path("notifications/read_all", views.notifications_read_all),
    path("audit/", audit_journal),
] + router.urls
