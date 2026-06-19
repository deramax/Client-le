from django.test import TestCase
from rest_framework.test import APIClient

from accounts.models import Role, User


class AuthFlowTests(TestCase):
    def setUp(self):
        Role.ensure_defaults()
        self.c = APIClient()

    def test_needs_setup_then_create_admin(self):
        self.assertTrue(self.c.get("/api/auth/needs_setup").json()["needs_setup"])
        r = self.c.post("/api/auth/setup",
                        {"fullName": "Admin", "login": "admin", "password": "Clientara2026!"},
                        format="json")
        self.assertEqual(r.status_code, 201)
        self.assertTrue(User.objects.filter(login="admin").exists())
        # once an admin exists, setup is no longer needed/allowed
        self.assertFalse(self.c.get("/api/auth/needs_setup").json()["needs_setup"])
        self.assertEqual(self.c.post("/api/auth/setup",
                         {"fullName": "x", "login": "x2", "password": "12345678"},
                         format="json").status_code, 400)

    def test_login_returns_tokens_and_me_has_permissions(self):
        User.objects.create_user(login="admin", password="pw123456", full_name="Admin",
                                 role="administrateur", is_staff=True, is_superuser=True)
        r = self.c.post("/api/auth/login", {"login": "admin", "password": "pw123456"}, format="json")
        self.assertEqual(r.status_code, 200)
        self.assertIn("access", r.json())
        self.c.credentials(HTTP_AUTHORIZATION="Bearer " + r.json()["access"])
        me = self.c.get("/api/auth/me").json()
        self.assertEqual(me["login"], "admin")
        self.assertTrue(me["permissions"]["dashboard"]["view"])

    def test_login_wrong_password_is_401(self):
        User.objects.create_user(login="admin", password="pw123456")
        r = self.c.post("/api/auth/login", {"login": "admin", "password": "nope"}, format="json")
        self.assertEqual(r.status_code, 401)

    def test_register_rejects_administrator_role(self):
        r = self.c.post("/api/auth/register",
                        {"fullName": "X", "login": "newbie", "role": "administrateur",
                         "password": "12345678"},
                        format="json")
        self.assertEqual(r.status_code, 400)

    def test_register_creates_agent_and_logs_in(self):
        r = self.c.post("/api/auth/register",
                        {"fullName": "Agent Un", "login": "agent1", "role": "agent",
                         "password": "12345678"},
                        format="json")
        self.assertEqual(r.status_code, 201)
        self.assertEqual(r.json()["user"]["role"], "agent")
