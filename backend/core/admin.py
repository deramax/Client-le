from django.contrib import admin

from .models import ClientRecord, Demande, RefItem


@admin.register(Demande)
class DemandeAdmin(admin.ModelAdmin):
    list_display = ["fid_id", "nom_client", "refnum", "requete_client",
                    "action", "niveau_decision", "date_reception"]
    search_fields = ["fid_id", "nom_client", "refnum"]
    list_filter = ["action", "niveau_decision", "technologie", "site"]


@admin.register(ClientRecord)
class ClientAdmin(admin.ModelAdmin):
    list_display = ["refnum", "nom_client"]
    search_fields = ["refnum", "nom_client"]


@admin.register(RefItem)
class RefItemAdmin(admin.ModelAdmin):
    list_display = ["category", "value", "order"]
    list_filter = ["category"]
