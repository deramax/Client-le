from django.db import models


class Demande(models.Model):
    """A retention request ("requête de fidélisation").

    Model fields are snake_case; the API serializer maps them to the exact
    French keys used by the legacy app (see core/serializers.py FIELD_MAP) so
    the React port consumes an identical schema.
    """

    fid_id = models.CharField(max_length=40, unique=True, db_index=True)  # FID-YYYY-NNNNN
    id_fid = models.CharField(max_length=20, blank=True)

    date_reception = models.CharField(max_length=20, blank=True)
    site = models.CharField(max_length=120, blank=True)
    agent_fidelisation = models.CharField(max_length=120, blank=True)
    refnum = models.CharField(max_length=60, blank=True, db_index=True)
    nom_client = models.CharField(max_length=200, blank=True)
    technologie = models.CharField(max_length=80, blank=True)

    ref_produit = models.CharField(max_length=80, blank=True)
    ancien_produit = models.CharField(max_length=160, blank=True)
    ancien_mensualite_ttc = models.FloatField(default=0)
    date_contrat = models.CharField(max_length=20, blank=True)

    requete_client = models.CharField(max_length=80, blank=True)
    motif = models.CharField(max_length=160, blank=True)
    information_libre = models.TextField(blank=True)

    action = models.CharField(max_length=80, blank=True)
    niveau_decision = models.CharField(max_length=40, blank=True, default="En Attente")
    date_cloture = models.CharField(max_length=20, blank=True)
    agent_confirmation = models.CharField(max_length=120, blank=True)
    date_prevue_execution = models.CharField(max_length=20, blank=True)
    priorite = models.CharField(max_length=40, blank=True)

    ref_nouv_produit = models.CharField(max_length=80, blank=True)
    nouveau_produit = models.CharField(max_length=160, blank=True)
    nouveau_mensualite_ttc = models.FloatField(default=0)
    nouveau_nom = models.CharField(max_length=200, blank=True)
    date_nv_contrat = models.CharField(max_length=20, blank=True)

    audit = models.JSONField(default=list, blank=True)  # modification trail (_audit)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ["-date_reception", "-id"]

    def __str__(self):
        return f"{self.fid_id} — {self.nom_client}"


class ClientRecord(models.Model):
    """Client directory (the app's own clients list: Refnum + name)."""

    refnum = models.CharField(max_length=60, unique=True, db_index=True)
    nom_client = models.CharField(max_length=200, blank=True)

    class Meta:
        ordering = ["nom_client"]

    def __str__(self):
        return f"{self.refnum} — {self.nom_client}"


class RefItem(models.Model):
    """A single reference value (referential), e.g. category='Sites' value='Masay'."""

    category = models.CharField(max_length=40, db_index=True)
    value = models.CharField(max_length=160)
    order = models.IntegerField(default=0)

    class Meta:
        ordering = ["category", "order", "value"]
        unique_together = ("category", "value")

    def __str__(self):
        return f"{self.category}: {self.value}"
