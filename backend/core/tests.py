from django.test import TestCase
from rest_framework.test import APIClient

from accounts.models import Role, User
from core.models import ClientRecord, Demande, RefItem


class ApiTests(TestCase):
    def setUp(self):
        Role.ensure_defaults()
        User.objects.create_user(login="admin", password="pw123456", full_name="Admin",
                                 role="administrateur", is_staff=True, is_superuser=True)
        self.c = APIClient()
        r = self.c.post("/api/auth/login", {"login": "admin", "password": "pw123456"}, format="json")
        self.c.credentials(HTTP_AUTHORIZATION="Bearer " + r.json()["access"])

        ClientRecord.objects.create(refnum="145238", nom_client="ANDRY Test")
        RefItem.objects.create(category="Sites", value="Masay")
        Demande.objects.create(fid_id="FID-2025-00001", refnum="145238", nom_client="ANDRY Test",
                               site="Masay", technologie="4G", requete_client="Résiliation",
                               action="Résiliation", niveau_decision="Cloturé",
                               ref_produit="566595", ancien_produit="4G_Gold",
                               ancien_mensualite_ttc=99000)
        Demande.objects.create(fid_id="FID-2025-00002", refnum="145238", nom_client="ANDRY Test",
                               site="Masay", technologie="4G", requete_client="Résiliation",
                               action="Basculement", niveau_decision="En Attente",
                               ancien_produit="4G_Gold", nouveau_produit="4G_1T",
                               ancien_mensualite_ttc=50000, nouveau_mensualite_ttc=80000)

    def test_demandes_list_uses_french_keys(self):
        data = self.c.get("/api/demandes/").json()
        self.assertEqual(len(data), 2)
        for key in ("id", "Date de réception", "Niveau décision", "Nom_Client", "Action"):
            self.assertIn(key, data[0])

    def test_kpis_retention_math(self):
        j = self.c.get("/api/kpis/").json()
        self.assertEqual(j["total"], 2)
        self.assertEqual(j["dem"], 2)        # both are résiliation requests
        self.assertEqual(j["perdus"], 1)     # one effective résiliation
        self.assertEqual(j["retenus"], 1)    # one basculement => retained
        self.assertEqual(j["taux"], 50)
        self.assertEqual(j["caSauve"], 80000)

    def test_create_requires_mandatory_fields(self):
        r = self.c.post("/api/demandes/", {"Nom_Client": "X"}, format="json")
        self.assertEqual(r.status_code, 400)

    def test_create_generates_fid_id(self):
        r = self.c.post("/api/demandes/", {
            "Nom_Client": "Nouveau", "Refnum": "999", "Site": "Masay",
            "Requête_client": "Résiliation", "Action": "Refusée", "Niveau décision": "En Attente",
        }, format="json")
        self.assertEqual(r.status_code, 201)
        self.assertTrue(r.json()["id"].startswith("FID-"))

    def test_referentiels_shape(self):
        j = self.c.get("/api/referentiels/").json()
        self.assertIn("Masay", j["Sites"])
        self.assertEqual(j["Niveaux"], ["En Attente", "Cloturé"])

    def test_fourd_demo_search_and_dossier(self):
        s = self.c.get("/api/fourd/clients/search?q=145238").json()
        self.assertEqual(s["count"], 1)
        d = self.c.get("/api/fourd/clients/145238").json()
        self.assertTrue(d["found"])
        self.assertEqual(d["client"]["refnum"], "145238")
        self.assertGreaterEqual(len(d["produits"]), 1)
