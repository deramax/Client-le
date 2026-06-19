"""Roles, modules and the default permission matrix.

Mirrors the legacy single-file app (ClienTara.html: ROLES, MODULES, CAPS,
defaultRoles) so behaviour is identical after the rebuild.
"""

MODULES = [
    "dashboard",
    "visualisation",
    "clients",
    "rapports",
    "audit",
    "parametres",
    "notifications",
    "journal",
]

CAPS = ["view", "create", "edit", "delete"]

# Navigation metadata (label + whether it shows in the side nav)
MODULE_META = {
    "dashboard": {"label": "Tableau de Bord", "navHidden": False},
    "visualisation": {"label": "Demandes", "navHidden": False},
    "clients": {"label": "Clients", "navHidden": False},
    "rapports": {"label": "Analyses", "navHidden": False},
    "audit": {"label": "Audit & Conformité", "navHidden": False},
    "parametres": {"label": "Paramètres", "navHidden": False},
    "notifications": {"label": "Notifications", "navHidden": True},
    "journal": {"label": "Journal d'audit", "navHidden": True},
}

ROLE_DEFS = [
    {"key": "administrateur", "name": "Administrateur",
     "description": "Accès total et inconditionnel", "locked": True, "order": 0},
    {"key": "responsable", "name": "Responsable fidélisation",
     "description": "Supervision & traitement", "locked": False, "order": 1},
    {"key": "agent", "name": "Agent de fidélisation",
     "description": "Traitement opérationnel des requêtes", "locked": False, "order": 2},
    {"key": "direction", "name": "Direction",
     "description": "Lecture & statistiques, sans modification métier", "locked": False, "order": 3},
    {"key": "audit", "name": "Audit",
     "description": "Lecture seule & accès au journal", "locked": False, "order": 4},
]

ROLE_KEYS = [r["key"] for r in ROLE_DEFS]


def _p(v, c, e, d):
    return {"view": bool(v), "create": bool(c), "edit": bool(e), "delete": bool(d)}


def default_role_matrix():
    """Identical to defaultRoles() in ClienTara.html."""
    return {
        "administrateur": {m: _p(1, 1, 1, 1) for m in MODULES},
        "responsable": {
            "dashboard": _p(1, 0, 0, 0), "visualisation": _p(1, 1, 1, 1),
            "clients": _p(1, 1, 1, 0), "rapports": _p(1, 0, 0, 0),
            "notifications": _p(1, 1, 0, 0), "parametres": _p(1, 0, 1, 0),
            "journal": _p(1, 0, 0, 0), "audit": _p(1, 0, 0, 0),
        },
        "agent": {
            "dashboard": _p(1, 0, 0, 0), "visualisation": _p(1, 1, 1, 0),
            "clients": _p(1, 1, 1, 0), "rapports": _p(1, 0, 0, 0),
            "notifications": _p(1, 0, 0, 0), "parametres": _p(0, 0, 0, 0),
            "journal": _p(0, 0, 0, 0), "audit": _p(0, 0, 0, 0),
        },
        "direction": {
            "dashboard": _p(1, 0, 0, 0), "visualisation": _p(1, 0, 0, 0),
            "clients": _p(1, 0, 0, 0), "rapports": _p(1, 0, 0, 0),
            "notifications": _p(1, 0, 0, 0), "parametres": _p(1, 0, 0, 0),
            "journal": _p(0, 0, 0, 0), "audit": _p(0, 0, 0, 0),
        },
        "audit": {m: _p(1, 0, 0, 0) for m in MODULES},
    }
