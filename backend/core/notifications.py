"""Server-side notification generation (ported from genNotifications())."""
from datetime import date

from .kpis import (
    is_closed,
    is_demande_resil,
    is_pending,
    is_resilie,
    is_retenu,
    mont_actuel,
    mont_ancien,
)


def _money(n):
    return f"{int(round(n)):,}".replace(",", " ") + " Ar"


def _fmt(s):
    return s or "—"


def generate_notifications(demandes, today=None):
    today = today or date.today()
    out = []
    ordered = sorted(demandes, key=lambda d: (d.date_reception or ""), reverse=True)

    # 1) pending & overdue (planned execution date passed)
    for d in demandes:
        if is_pending(d) and d.date_prevue_execution:
            try:
                ex = date.fromisoformat(d.date_prevue_execution[:10])
            except ValueError:
                ex = None
            if ex and ex < today:
                out.append({
                    "id": "over-" + d.fid_id, "type": "red", "title": "Requête en retard",
                    "body": f"{d.nom_client} — exécution prévue le {_fmt(d.date_prevue_execution)}, toujours en attente.",
                    "ts": d.date_prevue_execution, "did": d.fid_id,
                })

    # 2) high-value résiliations
    for d in [x for x in ordered if is_resilie(x) and mont_ancien(x) >= 189000][:6]:
        out.append({
            "id": "hv-" + d.fid_id, "type": "amber", "title": "Résiliation à enjeu élevé",
            "body": f"{d.nom_client} — perte de {_money(mont_ancien(d))}/mois ({d.ancien_produit or ''}).",
            "ts": d.date_reception, "did": d.fid_id,
        })

    # 3) recently saved clients
    for d in [x for x in ordered if is_retenu(x) and is_closed(x)][:6]:
        out.append({
            "id": "sv-" + d.fid_id, "type": "green", "title": "Client sauvegardé",
            "body": f"{d.nom_client} retenu via « {d.action} » — {_money(mont_actuel(d))}/mois préservé.",
            "ts": d.date_cloture or d.date_reception, "did": d.fid_id,
        })

    # 4) new pending
    for d in [x for x in ordered if is_pending(x)][:5]:
        out.append({
            "id": "new-" + d.fid_id, "type": "blue", "title": "Nouvelle requête en attente",
            "body": f"{d.nom_client} — {d.requete_client or 'requête'} ({d.site}).",
            "ts": d.date_reception, "did": d.fid_id,
        })

    seen, uniq = set(), []
    for n in out:
        if n["id"] in seen:
            continue
        seen.add(n["id"])
        uniq.append(n)
    uniq.sort(key=lambda n: (n["ts"] or ""), reverse=True)
    return uniq[:40]
