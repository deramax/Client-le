from rest_framework import serializers

from .kpis import num
from .models import ClientRecord, Demande

# Exact French API key  <->  model field. Output keys match ClienTara.html.
FIELD_MAP = {
    "id": "fid_id",
    "ID_FID": "id_fid",
    "Date de réception": "date_reception",
    "Site": "site",
    "Agent_fidélisation": "agent_fidelisation",
    "Refnum": "refnum",
    "Nom_Client": "nom_client",
    "Technologie": "technologie",
    "Réf_produit": "ref_produit",
    "Ancien_produit": "ancien_produit",
    "Ancien_Mensualité_TTC": "ancien_mensualite_ttc",
    "Date_Contrat": "date_contrat",
    "Requête_client": "requete_client",
    "Motif": "motif",
    "Information libre": "information_libre",
    "Action": "action",
    "Niveau décision": "niveau_decision",
    "Date_Cloture": "date_cloture",
    "Agent_Confirmation": "agent_confirmation",
    "Date prévue_Execution": "date_prevue_execution",
    "Priorité": "priorite",
    "Ref_nouv_produit": "ref_nouv_produit",
    "Nouveau_produit": "nouveau_produit",
    "Nouveau_Mensualité_TTC": "nouveau_mensualite_ttc",
    "Nouveau_Nom": "nouveau_nom",
    "Date_Nv_Contrat": "date_nv_contrat",
    "_audit": "audit",
}
NUMERIC_FIELDS = {"ancien_mensualite_ttc", "nouveau_mensualite_ttc"}


class DemandeSerializer(serializers.Serializer):
    """Translates between French JSON keys and the snake_case model."""

    def to_representation(self, obj):
        out = {}
        for fr, field in FIELD_MAP.items():
            val = getattr(obj, field)
            if field in NUMERIC_FIELDS:
                val = num(val)
            out[fr] = val
        return out

    def to_internal_value(self, data):
        validated = {}
        for fr, field in FIELD_MAP.items():
            if field in ("fid_id", "audit"):
                continue  # server-managed
            if fr in data:
                v = data.get(fr)
                if field in NUMERIC_FIELDS:
                    v = num(v)
                elif v is None:
                    v = ""
                validated[field] = v
        # required fields (legacy saveRequest)
        required = {
            "Nom_Client": "nom_client", "Refnum": "refnum", "Site": "site",
            "Requête_client": "requete_client", "Action": "action",
        }
        missing = [fr for fr, f in required.items()
                   if not str(validated.get(f, getattr(self.instance, f, "") if self.instance else "")).strip()]
        if missing and not self.partial:
            raise serializers.ValidationError(
                {"detail": "Veuillez renseigner les champs obligatoires : " + ", ".join(missing)}
            )
        return validated

    def create(self, validated):
        return Demande.objects.create(**validated)

    def update(self, instance, validated):
        # record a modification trail entry (legacy _audit)
        request = self.context.get("request")
        reason = ""
        changes = []
        if request:
            reason = (request.data.get("__reason") or "").strip()
        for field, new in validated.items():
            old = getattr(instance, field)
            if str(old) != str(new):
                changes.append({"field": field, "from": old, "to": new})
            setattr(instance, field, new)
        if changes or reason:
            role = getattr(getattr(request, "user", None), "role", "") if request else ""
            trail = list(instance.audit or [])
            trail.insert(0, {
                "ts": _now_iso(), "role": role, "reason": reason, "changes": changes,
            })
            instance.audit = trail
        instance.save()
        return instance


def _now_iso():
    from django.utils import timezone
    return timezone.now().isoformat()


class ClientSerializer(serializers.ModelSerializer):
    Refnum = serializers.CharField(source="refnum")
    Nom_Client = serializers.CharField(source="nom_client", required=False, allow_blank=True)

    class Meta:
        model = ClientRecord
        fields = ["Refnum", "Nom_Client"]
