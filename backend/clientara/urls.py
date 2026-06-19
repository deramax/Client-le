from django.contrib import admin
from django.http import JsonResponse
from django.urls import include, path


def root(_request):
    return JsonResponse(
        {
            "app": "ClienTara API",
            "docs": "/api/",
            "endpoints": [
                "/api/auth/", "/api/accounts/", "/api/demandes/",
                "/api/clients/", "/api/referentiels/", "/api/kpis/",
                "/api/rapports/", "/api/notifications/", "/api/audit/",
                "/api/fourd/",
            ],
        }
    )


urlpatterns = [
    path("", root),
    path("admin/", admin.site.urls),
    path("api/auth/", include("accounts.auth_urls")),
    path("api/accounts/", include("accounts.urls")),
    path("api/fourd/", include("fourd.urls")),
    path("api/", include("core.urls")),
]
