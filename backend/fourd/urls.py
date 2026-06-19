from django.urls import path

from . import views

urlpatterns = [
    path("health", views.health),
    path("config", views.config),
    path("clients/search", views.search),
    path("clients/<str:refnum>", views.dossier),
]
