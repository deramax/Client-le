"""
ClienTara <-> data source connector (ported from clientara-api/server.js).

Two modes, selected by settings.DATA_SOURCE:
  * demo        -> reads the local database (seeded from the Excel export).
  * production  -> reads a live 4D server over its REST API.   ⚠️ needs 4D.

Both return the identical shape to the app:
    {"client": {...}, "produits": [...], "contrats": [...]}

The 4D table/field names are read from fourd/mapping.json so production wiring
is configuration, not code (fill the 4D sections with the real names).
"""
import json
import re
from functools import lru_cache
from pathlib import Path

from django.conf import settings

MAPPING_PATH = Path(__file__).resolve().parent / "mapping.json"


@lru_cache(maxsize=1)
def mapping():
    return json.loads(MAPPING_PATH.read_text(encoding="utf-8"))


def _clean(v):
    return re.sub(r"\s+", " ", str("" if v is None else v)).strip()


# ==========================================================================
# DEMO — derive dossiers from the local DB (Demande rows = the Excel Journal)
# ==========================================================================
class DemoConnector:
    mode = "demo"

    def health(self):
        from core.models import ClientRecord
        return {"ok": True, "mode": self.mode, "clients": ClientRecord.objects.count()}

    def search(self, q):
        from core.models import ClientRecord
        q = (q or "").strip().lower()
        qs = ClientRecord.objects.all()
        out = []
        for c in qs:
            if (not q) or q in c.refnum.lower() or q in (c.nom_client or "").lower():
                out.append({"refnum": c.refnum, "nom": c.nom_client,
                            "mail": "", "telephone": "", "adresse": ""})
            if len(out) >= 25:
                break
        return out

    def dossier(self, refnum):
        from core.models import ClientRecord, Demande
        refnum = str(refnum).strip()
        client_row = ClientRecord.objects.filter(refnum=refnum).first()
        demandes = list(Demande.objects.filter(refnum=refnum))
        if not client_row and not demandes:
            return None
        nom = client_row.nom_client if client_row else (demandes[0].nom_client if demandes else "")
        client = {"refnum": refnum, "nom": nom, "mail": "", "telephone": "", "adresse": ""}

        produits, seen_p = [], set()
        contrats, seen_c = [], set()
        for d in demandes:
            tech = _clean(d.technologie)
            for pid, name in ((d.ref_produit, d.ancien_produit), (d.ref_nouv_produit, d.nouveau_produit)):
                name = _clean(name)
                if not name:
                    continue
                key = f"{refnum}|{_clean(pid)}|{name}"
                if key in seen_p:
                    continue
                seen_p.add(key)
                produits.append({"id_produit": _clean(pid), "intitule": name,
                                 "technologie": tech, "produit": name})
            for dt in (d.date_contrat, d.date_nv_contrat):
                dt = _clean(dt)
                if not dt:
                    continue
                key = f"{refnum}|{dt}"
                if key in seen_c:
                    continue
                seen_c.add(key)
                contrats.append({"id_contrat": f"CT-{refnum}-{dt[:4]}", "type_contrat": "",
                                 "date_debut": dt, "date_fin": "", "duree": "", "facturation": ""})
        return {"client": client, "produits": produits, "contrats": contrats}


# ==========================================================================
# PRODUCTION — live 4D REST  (⚠️ requires a reachable 4D server + credentials)
# ==========================================================================
class FourdConnector:
    mode = "production"

    def __init__(self):
        self._cookie = ""

    def health(self):
        return {"ok": True, "mode": self.mode,
                "fourdConfigured": bool(settings.FOURD_URL),
                "fourdUrl": settings.FOURD_URL or None}

    def _login(self):
        import requests
        if not settings.FOURD_USER:
            return
        r = requests.post(
            f"{settings.FOURD_URL}/rest/$directory/login",
            headers={"username": settings.FOURD_USER, "password": settings.FOURD_PASSWORD},
            timeout=settings.FOURD_TIMEOUT,
        )
        cookie = r.headers.get("set-cookie")
        if cookie:
            self._cookie = cookie.split(";")[0]
        r.raise_for_status()

    def _get(self, rest_path, retry=True):
        import requests
        headers = {"Cookie": self._cookie} if self._cookie else {}
        r = requests.get(f"{settings.FOURD_URL}/rest/{rest_path}",
                         headers=headers, timeout=settings.FOURD_TIMEOUT)
        if r.status_code in (401, 403) and retry:
            self._login()
            return self._get(rest_path, retry=False)
        r.raise_for_status()
        return r.json()

    @staticmethod
    def _esc(v):
        return str(v).replace("'", "\\'")

    @staticmethod
    def _attrs(field_map):
        s = []
        for c, name in field_map.items():
            if c == "_search":
                continue
            if c.startswith("_"):
                if isinstance(name, str):
                    s.append(name)
                continue
            s.append(name)
        return ",".join(dict.fromkeys(s))

    @staticmethod
    def _map_entity(entity, field_map):
        out = {}
        for c, name in field_map.items():
            if c.startswith("_"):
                continue
            out[c] = entity.get(name, "") if entity.get(name) is not None else ""
        return out

    def search(self, q):
        from urllib.parse import quote
        m = mapping()
        dc, fm = m["dataClasses"]["client"], m["client"]
        attrs = self._attrs(fm)
        if q and q.strip():
            parts = [f"{a}='@{self._esc(q.strip())}@'" for a in fm.get("_search", [fm["refnum"]])]
            flt = quote("(" + ") OR (".join(parts) + ")")
            url = f"{dc}/?$filter={flt}&$attributes={attrs}&$top=25"
        else:
            url = f"{dc}/?$attributes={attrs}&$top=25"
        data = self._get(url)
        return [self._map_entity(e, fm) for e in data.get("__ENTITIES", [])]

    def _linked(self, data_class, field_map, refnum):
        from urllib.parse import quote
        fk = field_map.get("_client_fk")
        if not fk:
            return []
        attrs = self._attrs(field_map)
        try:
            flt = quote(f"{fk}='{self._esc(refnum)}'")
            data = self._get(f"{data_class}/?$filter={flt}&$attributes={attrs}&$top=100")
            return [self._map_entity(e, field_map) for e in data.get("__ENTITIES", [])]
        except Exception:
            return []

    def dossier(self, refnum):
        from urllib.parse import quote
        m = mapping()
        dc, fm = m["dataClasses"]["client"], m["client"]
        flt = quote(f"{fm['refnum']}='{self._esc(refnum)}'")
        data = self._get(f"{dc}/?$filter={flt}&$attributes={self._attrs(fm)}")
        ents = data.get("__ENTITIES", [])
        if not ents:
            return None
        client = self._map_entity(ents[0], fm)
        produits = self._linked(m["dataClasses"]["produit"], m["produit"], refnum)
        contrats = self._linked(m["dataClasses"]["contrat"], m["contrat"], refnum)
        return {"client": client, "produits": produits, "contrats": contrats}


def get_connector():
    if settings.DATA_SOURCE == "production":
        return FourdConnector()
    return DemoConnector()
