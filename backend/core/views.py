from rest_framework import status, viewsets
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from accounts.models import NotificationRead
from accounts.permissions import ModulePermission, can

from . import kpis as K
from .models import ClientRecord, Demande, RefItem
from .notifications import generate_notifications
from .serializers import ClientSerializer, DemandeSerializer

REF_CATEGORIES = [
    "Sites", "Agents", "Technologies", "Produits",
    "Requetes", "Motifs", "Actions", "Niveaux", "Priorites",
]


def _next_fid(year):
    import re
    mx = 0
    for fid in Demande.objects.values_list("fid_id", flat=True):
        m = re.match(r"^FID-\d{4}-(\d+)$", fid or "")
        if m:
            mx = max(mx, int(m.group(1)))
    return f"FID-{year}-{mx + 1:05d}"


class DemandeViewSet(viewsets.ModelViewSet):
    queryset = Demande.objects.all()
    serializer_class = DemandeSerializer
    permission_classes = [IsAuthenticated, ModulePermission]
    module = "visualisation"
    pagination_class = None
    lookup_field = "fid_id"
    lookup_value_regex = "[^/]+"

    def perform_create(self, serializer):
        data = serializer.validated_data
        year = (data.get("date_reception") or "")[:4] or str(__import__("datetime").date.today().year)
        fid = _next_fid(year)
        serializer.save(fid_id=fid, id_fid=str(Demande.objects.count() + 1),
                        niveau_decision=data.get("niveau_decision") or "En Attente")


def _filtered(request):
    q = request.query_params
    return K.apply_filters(
        list(Demande.objects.all()),
        frm=q.get("from"), to=q.get("to"),
        site=q.get("site"), tech=q.get("tech"), agent=q.get("agent"),
    )


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def clients(request):
    if not can(request.user, "clients", "view"):
        return Response({"detail": "Accès refusé."}, status=403)
    return Response(ClientSerializer(ClientRecord.objects.all(), many=True).data)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def referentiels(request):
    out = {c: [] for c in REF_CATEGORIES}
    for item in RefItem.objects.all():
        out.setdefault(item.category, []).append(item.value)
    out.setdefault("Niveaux", [])
    if not out["Niveaux"]:
        out["Niveaux"] = ["En Attente", "Cloturé"]
    if not out.get("Priorites"):
        out["Priorites"] = ["Faible", "Normale", "Haute", "Critique"]
    return Response(out)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def dashboard_kpis(request):
    if not can(request.user, "dashboard", "view"):
        return Response({"detail": "Accès refusé."}, status=403)
    data = _filtered(request)
    payload = K.kpis(data)
    payload["monthly"] = K.monthly_series(data)
    payload["byTech"] = K.resil_by_tech(data)
    return Response(payload)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def rapports(request):
    if not can(request.user, "rapports", "view"):
        return Response({"detail": "Accès refusé."}, status=403)
    data = _filtered(request)
    dem_resil = [d for d in data if K.is_demande_resil(d)]
    ser = DemandeSerializer
    return Response({
        "stats": K.retention_stats(data),
        "byTech": K.resil_by_tech(data),
        "agents": K.agent_perf(data),
        "productMotif": K.resil_product_motif(data),
        "monthly": K.monthly_series(data),
        "resiliations": ser([d for d in dem_resil if K.is_resilie(d)], many=True).data,
        "retentions": ser([d for d in dem_resil if not K.is_resilie(d)], many=True).data,
        "upcoming": ser(K.scheduled_resil(data), many=True).data,
    })


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def notifications(request):
    if not can(request.user, "notifications", "view"):
        return Response({"detail": "Accès refusé."}, status=403)
    items = generate_notifications(list(Demande.objects.all()))
    read = set(NotificationRead.objects.filter(user=request.user)
               .values_list("notif_id", flat=True))
    for n in items:
        n["read"] = n["id"] in read
    unread = sum(1 for n in items if not n["read"])
    return Response({"items": items, "unread": unread})


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def notifications_read_all(request):
    items = generate_notifications(list(Demande.objects.all()))
    NotificationRead.objects.bulk_create(
        [NotificationRead(user=request.user, notif_id=n["id"]) for n in items],
        ignore_conflicts=True,
    )
    return Response({"ok": True})
