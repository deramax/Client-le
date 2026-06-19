"""
Aggregations & business logic, ported 1:1 from ClienTara.html.

Operates on `Demande` model instances (snake_case attributes). The retention
semantics are the legacy "source of truth": the at-risk population is the set
of *résiliation* requests; a client is "retained" when such a request ends in
anything other than an effective résiliation.
"""
from datetime import date


def num(v):
    try:
        n = float(v)
        return 0.0 if n != n else n  # NaN guard
    except (TypeError, ValueError):
        return 0.0


# ---- request semantics ---------------------------------------------------
def is_resilie(d):
    return d.action == "Résiliation"


def is_retenu(d):
    return not is_resilie(d)


def is_bascule(d):
    return d.action == "Basculement"


def is_pending(d):
    return (d.niveau_decision or "") == "En Attente"


def is_closed(d):
    return (d.niveau_decision or "") == "Cloturé"


def is_demande_resil(d):
    return (d.requete_client or "") == "Résiliation"


def mont_ancien(d):
    return num(d.ancien_mensualite_ttc)


def mont_nouveau(d):
    return num(d.nouveau_mensualite_ttc)


def mont_actuel(d):
    if is_resilie(d):
        return 0.0
    n = mont_nouveau(d)
    return n if n > 0 else mont_ancien(d)


def month_key(s):
    if not s or len(str(s)) < 7:
        return None
    s = str(s)
    try:
        date.fromisoformat(s[:10])
    except ValueError:
        return None
    return s[:7]  # YYYY-MM


# ---- filtering -----------------------------------------------------------
def apply_filters(demandes, *, frm=None, to=None, site=None, tech=None, agent=None):
    out = []
    for d in demandes:
        dr = d.date_reception or ""
        if frm and dr and dr < frm:
            continue
        if to and dr and dr > to:
            continue
        if site and d.site != site:
            continue
        if tech and d.technologie != tech:
            continue
        if agent and d.agent_fidelisation != agent:
            continue
        out.append(d)
    return out


# ---- aggregations --------------------------------------------------------
def retention_stats(demandes):
    dem = [d for d in demandes if is_demande_resil(d)]
    retenus = perdus = 0
    ca_perdu = ca_sauve = 0.0
    for d in dem:
        if is_resilie(d):
            perdus += 1
            ca_perdu += mont_ancien(d)
        else:
            retenus += 1
            ca_sauve += mont_actuel(d)
    n = len(dem)
    return {
        "dem": n, "retenus": retenus, "perdus": perdus,
        "taux": round(retenus / n * 100) if n else 0,
        "caPerdu": ca_perdu, "caSauve": ca_sauve,
    }


def kpis(demandes):
    pending = closed = basc = 0
    ca_actuel = 0.0
    for d in demandes:
        if is_pending(d):
            pending += 1
        else:
            closed += 1
        if is_retenu(d):
            ca_actuel += mont_actuel(d)
        if is_bascule(d):
            basc += 1
    rf = retention_stats(demandes)
    return {
        "total": len(demandes), "pending": pending, "closed": closed,
        "basc": basc, "caActuel": ca_actuel,
        "res": rf["perdus"], "ret": rf["retenus"], "taux": rf["taux"],
        "dem": rf["dem"], "retenus": rf["retenus"], "perdus": rf["perdus"],
        "caRes": rf["caPerdu"], "caRet": rf["caSauve"],
        "caPerdu": rf["caPerdu"], "caSauve": rf["caSauve"],
    }


def all_months(demandes):
    s = set()
    for d in demandes:
        k = month_key(d.date_reception)
        if k:
            s.add(k)
    return sorted(s)


def monthly_series(demandes):
    months = all_months(demandes)
    recu = {k: 0 for k in months}
    res = {k: 0.0 for k in months}
    ret = {k: 0.0 for k in months}
    basc = {k: 0 for k in months}
    for d in demandes:
        k = month_key(d.date_reception)
        if not k or k not in recu:
            continue
        recu[k] += 1
        if is_demande_resil(d):
            if is_resilie(d):
                res[k] += mont_ancien(d)
            else:
                ret[k] += mont_actuel(d)
        if is_bascule(d):
            basc[k] += 1
    return {"months": months, "recu": recu, "res": res, "ret": ret, "basc": basc}


def resil_by_tech(demandes):
    m = {}
    for d in demandes:
        if not is_demande_resil(d):
            continue
        t = d.technologie or "—"
        slot = m.setdefault(t, {"dem": 0, "retenus": 0, "perdus": 0})
        slot["dem"] += 1
        if is_resilie(d):
            slot["perdus"] += 1
        else:
            slot["retenus"] += 1
    rows = [
        {"tech": t, "dem": s["dem"], "retenus": s["retenus"], "perdus": s["perdus"],
         "taux": round(s["retenus"] / s["dem"] * 100) if s["dem"] else 0}
        for t, s in m.items()
    ]
    return sorted(rows, key=lambda r: -r["dem"])


def agent_perf(demandes):
    by = {}
    for d in demandes:
        a = d.agent_fidelisation or "—"
        r = by.setdefault(a, {"agent": a, "total": 0, "dem": 0, "retenus": 0,
                              "perdus": 0, "caSauve": 0.0, "caPerdu": 0.0})
        r["total"] += 1
        if is_demande_resil(d):
            r["dem"] += 1
            if is_resilie(d):
                r["perdus"] += 1
                r["caPerdu"] += mont_ancien(d)
            else:
                r["retenus"] += 1
                r["caSauve"] += mont_actuel(d)
    rows = list(by.values())
    for r in rows:
        r["taux"] = round(r["retenus"] / r["dem"] * 100) if r["dem"] else 0
    return sorted(rows, key=lambda r: -r["dem"])


def resil_product_motif(demandes):
    dem = [d for d in demandes if is_demande_resil(d) and is_resilie(d)]
    techs, motif_totals = {}, {}
    for d in dem:
        t = d.technologie or "—"
        mo = d.motif or "—"
        techs.setdefault(t, {})
        techs[t][mo] = techs[t].get(mo, 0) + 1
        motif_totals[mo] = motif_totals.get(mo, 0) + 1
    motifs = sorted(motif_totals, key=lambda m: -motif_totals[m])
    tech_list = sorted(techs, key=lambda t: -sum(techs[t].values()))
    return {"techs": techs, "motifs": motifs, "techList": tech_list,
            "motifTotals": motif_totals, "total": len(dem)}


def scheduled_resil(demandes):
    import re

    def ok(d):
        return (is_resilie(d) or (is_demande_resil(d) and is_pending(d))) and \
            re.match(r"^\d{4}-\d\d-\d\d$", d.date_prevue_execution or "")

    rows = [d for d in demandes if ok(d)]
    return sorted(rows, key=lambda d: d.date_prevue_execution or "")
