# ClienTara — Plateforme de fidélisation client

Application de gestion des requêtes de fidélisation (résiliations, rétention,
basculements…), reconstruite sur une pile moderne :

**React (Vite)** · **Django + DRF** · **PostgreSQL** · **Docker** · **LDAP + MFA** · connecteur **4D**

> Refonte de l'application mono-fichier d'origine `ClienTara.html` (conservée
> comme référence, avec `clientara-api/`, `mapping.json` et le snippet d'intégration).

---

## Démarrage rapide (Docker)

```bash
cp .env.example .env          # adapter si besoin
docker compose up --build     # construit et lance toute la pile
```

- Application : <http://localhost:8080>
- API + admin Django : <http://localhost:8000>
- Connexion : **admin / Clientara2026!** (modifiable dans `.env`)

La base est automatiquement migrée et alimentée avec le jeu de démonstration
(**666 demandes, 640 clients**) au premier démarrage.

### Avec l'annuaire LDAP de démonstration

```bash
docker compose --profile ldap up --build
# puis dans .env : LDAP_ENABLED=true   (comptes de test : jrakoto / clientara)
```

---

## Développement local (sans Docker)

**Backend** (utilise SQLite automatiquement si `DB_HOST` est vide) :

```bash
cd backend
python -m venv .venv && . .venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py seed_demo
python manage.py runserver          # http://localhost:8000
python manage.py test               # tests
```

**Frontend** :

```bash
cd frontend
npm install
npm run dev                         # http://localhost:5173 (proxy /api -> :8000)
npm run build                       # build de production
```

---

## Architecture

```
backend/     Django + DRF — API, RBAC, JWT, MFA, connecteur 4D, LDAP (optionnel)
  accounts/  utilisateurs, rôles/permissions, auth (login, MFA, register), journal
  core/      Demande/Client/Référentiel, KPIs, analyses, notifications, seed
  fourd/     connecteur 4D (démo via BDD / production REST) piloté par mapping.json
frontend/    React (Vite) — port fidèle du design (4 thèmes) et des fonctionnalités
ldap/        annuaire LDAP de démonstration (seed.ldif)
docker-compose.yml · .env.example · FEUILLE_DE_ROUTE.md
```

Principaux endpoints API (sous `/api/`) : `auth/`, `accounts/`, `demandes/`,
`clients/`, `referentiels/`, `kpis/`, `rapports/`, `notifications/`, `audit/`,
`fourd/`.

---

## Périmètre

- **◑ Constructible en local** : front + back + PostgreSQL + données de démo +
  MFA — tout fonctionne via Docker, sans dépendance externe.
- **⚠️ Nécessite l'infrastructure DSI** :
  - **LDAP / Active Directory** réel (auth entreprise) — voir `backend/accounts/ldap_config.py`.
  - **Serveur 4D** réel (mode `DATA_SOURCE=production`) — renseigner `mapping.json` + `.env`.

La suite des étapes (avec acteurs, outils et dépendances DSI) est détaillée dans
**[FEUILLE_DE_ROUTE.md](FEUILLE_DE_ROUTE.md)**.

---

## Sécurité

- Authentification **JWT** ; **MFA (TOTP)** activable par utilisateur.
- **RBAC** : 5 rôles (administrateur, responsable, agent, direction, audit).
- Journal d'audit des connexions.
- Ne jamais committer `.env` ni les données clients réelles (`*.xlsx`). En
  production : `DJANGO_SECRET_KEY` forte, `DJANGO_DEBUG=false`, HTTPS, compte 4D
  en lecture seule.
