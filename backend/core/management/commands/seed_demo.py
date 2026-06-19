"""
Seed the database from the extracted demo dataset (core/fixtures/seed.json:
666 demandes + 640 clients + référentiels, sourced from the original Excel).

Idempotent: replaces demandes/clients/référentiels, ensures the five roles and
the initial administrator account. Users are preserved across runs.

    python manage.py seed_demo
    python manage.py seed_demo --admin-password "S3cret!" --keep-data
"""
import json
from pathlib import Path

from django.conf import settings
from django.core.management.base import BaseCommand

from accounts.models import Role, User
from core.models import ClientRecord, Demande, RefItem
from core.serializers import FIELD_MAP, NUMERIC_FIELDS
from core.kpis import num

# seed referential key -> our canonical category
REF_SOURCE = {
    "Sites": "Sites", "Agents": "Agents", "Technologies": "Technologies",
    "Produits": "Produits", "Requêtes": "Requetes", "Motifs": "Motifs",
    "Actions": "Actions", "Priorités": "Priorites",
}


class Command(BaseCommand):
    help = "Charge le jeu de données de démonstration et crée le compte admin."

    def add_arguments(self, parser):
        import os

        parser.add_argument("--admin-login", default=os.environ.get("DJANGO_ADMIN_LOGIN", "admin"))
        parser.add_argument("--admin-password",
                            default=os.environ.get("DJANGO_ADMIN_PASSWORD", "Clientara2026!"))
        parser.add_argument("--keep-data", action="store_true",
                            help="Ne pas réinitialiser demandes/clients/référentiels.")

    def handle(self, *args, **opts):
        seed_path = Path(settings.BASE_DIR) / "core" / "fixtures" / "seed.json"
        data = json.loads(seed_path.read_text(encoding="utf-8"))

        Role.ensure_defaults()
        self.stdout.write(self.style.SUCCESS(f"Rôles : {Role.objects.count()}"))

        self._ensure_admin(opts["admin_login"], opts["admin_password"])

        if not opts["keep_data"]:
            Demande.objects.all().delete()
            ClientRecord.objects.all().delete()
            RefItem.objects.all().delete()

        self._seed_referentiels(data.get("referentiels", {}))
        self._seed_clients(data.get("clients", []))
        self._seed_demandes(data.get("demandes", []))

        self.stdout.write(self.style.SUCCESS(
            f"OK — {Demande.objects.count()} demandes, "
            f"{ClientRecord.objects.count()} clients, "
            f"{RefItem.objects.count()} valeurs de référentiel."
        ))

    def _ensure_admin(self, login, password):
        if User.objects.filter(login=login).exists():
            self.stdout.write(f"Admin « {login} » déjà présent (inchangé).")
            return
        User.objects.create_user(
            login=login, password=password, full_name="Administrateur",
            role="administrateur", is_staff=True, is_superuser=True,
        )
        self.stdout.write(self.style.WARNING(
            f"Admin créé — login: {login} / mot de passe: {password}"
        ))

    def _seed_referentiels(self, ref):
        seen = set()
        bulk = []
        for src, cat in REF_SOURCE.items():
            values, order = ref.get(src, []) or [], 0
            for v in values:
                v = (str(v) if v is not None else "").strip()
                key = (cat, v)
                if not v or key in seen:
                    continue
                seen.add(key)
                bulk.append(RefItem(category=cat, value=v, order=order))
                order += 1
        for v in ["En Attente", "Cloturé"]:
            if ("Niveaux", v) not in seen:
                bulk.append(RefItem(category="Niveaux", value=v))
        RefItem.objects.bulk_create(bulk, ignore_conflicts=True)

    def _seed_clients(self, clients):
        bulk, seen = [], set()
        for c in clients:
            ref = str(c.get("Refnum") or "").strip()
            if not ref or ref in seen:
                continue
            seen.add(ref)
            bulk.append(ClientRecord(refnum=ref, nom_client=(c.get("Nom_Client") or "").strip()))
        ClientRecord.objects.bulk_create(bulk, ignore_conflicts=True)

    def _seed_demandes(self, demandes):
        bulk, seen = [], set()
        for row in demandes:
            kwargs = {}
            for fr, field in FIELD_MAP.items():
                if fr not in row:
                    continue
                val = row.get(fr)
                if field in NUMERIC_FIELDS:
                    val = num(val)
                elif field == "audit":
                    val = val or []
                elif val is None:
                    val = ""
                kwargs[field] = val
            fid = kwargs.get("fid_id") or ""
            if not fid or fid in seen:
                continue
            seen.add(fid)
            kwargs.setdefault("niveau_decision", "En Attente")
            bulk.append(Demande(**kwargs))
        Demande.objects.bulk_create(bulk, ignore_conflicts=True, batch_size=500)
