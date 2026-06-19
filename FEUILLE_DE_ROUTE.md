# Feuille de route — Refonte ClienTara
### Pile cible : React + Django + PostgreSQL + Docker + LDAP

**Légende des acteurs**

| Symbole | Acteur | Rôle |
|---|---|---|
| 🧑‍💼 **Moi** | Chef de projet / vous | Pilotage, configuration applicative, recette, décisions |
| 🤖 **Dév. IA** | Claude Code | Génération du code, tests techniques, documentation |
| 🏢 **DSI** | Direction des Systèmes d'Information | Serveurs, réseau, comptes, annuaire, 4D, sécurité |

**Légende des sources**

- 🟢 *Open source téléchargeable en ligne* (gratuit)
- 🔵 *Déjà fourni / déjà dans le projet*
- 🟠 *À demander / attendre la DSI*

---

## PARTIE A — Étapes DÉJÀ FAITES ✅

| # | Étape | Réalisé par | Outils / Logiciels | Source | Statut |
|---|---|---|---|---|---|
| A1 | Analyse de l'existant (`ClienTara.html`, `mapping.json`, snippet d'intégration) | 🤖 | Lecture de code | 🔵 fourni | ✅ |
| A2 | Extraction du jeu de données de démo (`seed.json` : 666 demandes, 640 clients, référentiels) | 🤖 | Python 3.11 | 🔵 Excel source | ✅ |
| A3 | Modèle de base de données (Demande, Client, Référentiel, User, Role, Journal d'audit) | 🤖 | Django ORM | 🟢 | ✅ |
| A4 | API REST (demandes, clients, référentiels, KPIs, analyses, notifications, audit) | 🤖 | Django REST Framework | 🟢 | ✅ |
| A5 | Authentification par jeton **JWT** (login / refresh) | 🤖 | djangorestframework-simplejwt | 🟢 | ✅ |
| A6 | **MFA** (double authentification TOTP) | 🤖 | pyotp | 🟢 | ✅ (testable en local) |
| A7 | Rôles & permissions (**RBAC** : 5 rôles, 8 modules) | 🤖 | Django | 🟢 | ✅ |
| A8 | Connecteur **4D** (mode démo BDD + mode production REST piloté par `mapping.json`) | 🤖 | requests | 🟢 | ✅ code / ⚠️ prod à brancher |
| A9 | Configuration **LDAP** (optionnelle, désactivée par défaut) | 🤖 | django-auth-ldap | 🟢 | ✅ code / ⚠️ infra à fournir |
| A10 | Commande d'amorçage des données (`seed_demo`) | 🤖 | Django mgmt command | 🟢 | ✅ |
| A11 | Migrations + validation locale (`check` / `migrate` / `seed`) | 🤖 | **SQLite** (local) | 🟢 | ✅ |
| A12 | **Frontend React** : design system (4 thèmes), contextes Auth/Data/Theme, client API JWT, toutes les vues | 🤖 | React 18, Vite, Chart.js, react-router | 🟢 | ✅ |
| A13 | Build de production du frontend | 🤖 | Vite | 🟢 | ✅ (73 modules) |
| A14 | Test d'intégration front ↔ back (login + endpoints → 200) | 🤖 | Django runserver + curl | 🟢 | ✅ |
| A15 | `Dockerfile` + `nginx.conf` du frontend | 🤖 | Docker, nginx | 🟢 | ✅ |
| A16 | Versionnement (`.gitignore`, commit, push branche) | 🤖 | Git | 🟢 | ✅ |

> **Note d'honnêteté** : le backend est validé **en local sur SQLite + serveur de développement**. Le branchement réel **PostgreSQL** + l'orchestration Docker complète restent à faire (Partie B, Phase 1).

---

## PARTIE B — Étapes À FAIRE 🚧

### Phase 1 — Conteneurisation & exécution locale complète

| # | Étape | Outils | Qui | Source | Accès | Recommandation |
|---|---|---|---|---|---|---|
| B1 | Écrire `backend/Dockerfile` + `entrypoint.sh` | Docker | 🤖 + 🧑‍💼 | 🟢 | — | Image `python:3.12-slim` ; installer `libldap2-dev`/`libsasl2-dev` pour activer LDAP plus tard |
| B2 | Écrire `docker-compose.yml` (services : **db** Postgres + **backend** + **frontend** + **openldap** de test) | Docker Compose | 🤖 + 🧑‍💼 | 🟢 | — | Utiliser des *profils* (`default` vs `ldap`) pour ne lancer LDAP qu'au besoin |
| B3 | **Liaison PostgreSQL ↔ serveur backend** | Docker, PostgreSQL 16 | 🧑‍💼 | 🟢 téléchargeable | Identifiants de prod = 🟠 DSI | Volume persistant pour les données ; en local, identifiants par défaut suffisent |
| B4 | Créer `.env` à partir de `.env.example` | Éditeur de texte | 🧑‍💼 | 🔵 | Secrets = 🟠 DSI | **Ne jamais committer** `.env` ; générer une `DJANGO_SECRET_KEY` forte |
| B5 | Lancer la pile complète (`docker compose up`) et vérifier seed + login | Docker | 🧑‍💼 | 🟢 | — | Valider les 666 demandes et la connexion `admin` avant d'aller plus loin |

### Phase 2 — Sécurité & authentification entreprise (⚠️ dépend DSI)

| # | Étape | Outils | Qui | Source | Accès | Recommandation |
|---|---|---|---|---|---|---|
| B6 | Fournir l'**annuaire LDAP / Active Directory** réel | Serveur AD/LDAP | 🏢 DSI (fournit) → 🤖/🧑‍💼 (configure) | 🟠 attendre DSI | Demander : URL LDAP(S), `BIND_DN`, mot de passe du compte service, `USER_BASE` | Compte de service **lecture seule** ; privilégier **LDAPS (port 636)** |
| B7 | Renseigner les variables LDAP dans `.env` et activer `LDAP_ENABLED=true` | Éditeur | 🧑‍💼 (avec infos DSI) | 🟠 | Infos = DSI | Tester d'abord avec **un compte pilote** |
| B8 | Politique **MFA** en production | pyotp (déjà codé) | 🧑‍💼 / 🏢 | 🔵 fait | — | Rendre le MFA **obligatoire** pour les rôles sensibles ; prévoir des codes de secours |
| B9 | Clés secrètes & **certificats HTTPS** | Gestionnaire de secrets, certificats | 🏢 DSI | 🟠 attendre DSI | Demande DSI | `DJANGO_SECRET_KEY` ≥ 50 caractères ; HTTPS obligatoire derrière reverse-proxy |

### Phase 3 — Intégration 4D réelle (⚠️ dépend DSI / éditeur 4D)

| # | Étape | Outils | Qui | Source | Accès | Recommandation |
|---|---|---|---|---|---|---|
| B10 | Donner l'**accès au serveur 4D REST** | Connecteur déjà écrit | 🏢 DSI (fournit) | 🟠 attendre DSI | Demander : `FOURD_URL`, compte **lecture seule**, ouverture réseau/port | Tester en **mode démo** d'abord ; jamais de compte en écriture |
| B11 | Renseigner `mapping.json` avec les **vrais noms** de tables/champs 4D | Éditeur + schéma 4D | 🧑‍💼 / 🏢 (avec schéma DSI) | 🟠 schéma = DSI | Schéma 4D = DSI | Valider **champ par champ** sur quelques clients témoins |
| B12 | Basculer `DATA_SOURCE=production` | `.env` | 🧑‍💼 | 🔵 | — | Conserver le mode démo pour la formation et les tests |

### Phase 4 — Déploiement & exploitation

| # | Étape | Outils | Qui | Source | Accès | Recommandation |
|---|---|---|---|---|---|---|
| B13 | Serveur cible (VM / hôte Docker) | Serveur Linux | 🏢 DSI | 🟠 attendre DSI | Demande DSI | Min. 2 vCPU / 4 Go RAM ; Docker installé |
| B14 | Nom de domaine + **certificat TLS** | DNS, Let's Encrypt ou PKI interne | 🏢 DSI | 🟠 attendre DSI | Demande DSI | Activer HTTPS + HSTS |
| B15 | **Sauvegardes** de la base | `pg_dump` ou outil DSI | 🏢 DSI | 🟢 / logiciel DSI | — | Sauvegarde quotidienne + **test de restauration** régulier |
| B16 | **CI/CD** (build, tests, déploiement automatique) | GitHub Actions / GitLab CI | 🤖 + 🧑‍💼 | 🟢 | Accès dépôt = DSI | Pipeline : lint → tests → build → image Docker |
| B17 | Supervision & journaux (logs, alertes) | Sentry / Prometheus+Grafana ou outils DSI | 🏢 / 🧑‍💼 | 🟢 ou logiciel DSI | — | Alerter sur erreurs 5xx et échecs de connexion |
| B18 | Tests automatisés (backend + frontend) | pytest, Vitest | 🤖 / 🧑‍💼 | 🟢 | — | Couvrir KPIs, auth/MFA, connecteur 4D |

### Phase 5 — Conformité & reprise des données

| # | Étape | Outils | Qui | Source | Accès | Recommandation |
|---|---|---|---|---|---|---|
| B19 | Conformité **RGPD / protection des données** | — | 🏢 DSI / DPO | 🟠 | Validation DPO | Chiffrement au repos, minimisation ; le journal d'audit est déjà en place |
| B20 | Reprise des **données réelles** (Excel/4D → PostgreSQL) | Script de seed / ETL | 🤖 / 🧑‍💼 (avec données DSI) | 🟠 données = DSI | Données = DSI | **Anonymiser** les données pour les environnements de test |
| B21 | Formation utilisateurs & **recette métier** | L'application | 🧑‍💼 | 🔵 | — | Faire la recette sur le **mode démo** avant la bascule production |

---

## Synthèse — Ce qui BLOQUE et dépend de la DSI 🟠

| Besoin | Pourquoi | À demander précisément |
|---|---|---|
| **Annuaire LDAP/AD** | Authentification entreprise (B6–B7) | URL LDAPS, DN de bind, compte service lecture seule, base DN |
| **Accès 4D REST** | Données clients réelles (B10–B11) | URL REST, compte lecture seule, ouverture réseau, **schéma des tables/champs** |
| **Serveur + HTTPS + domaine** | Mise en production (B13–B14) | VM/hôte Docker, certificat TLS, entrée DNS |
| **Données réelles + feu vert RGPD** | Reprise & conformité (B19–B20) | Export de données, validation DPO |

## Ce que je (🤖) peux enchaîner immédiatement, sans la DSI

1. **B1 + B2** : `Dockerfile` backend, `entrypoint.sh`, `docker-compose.yml` (Postgres + backend + frontend + LDAP de test).
2. **B4** : `.env.example` complet et documenté.
3. **B16/B18** : squelette CI + premiers tests automatisés.
4. Un **openldap de démonstration** (`ldap/seed.ldif`) pour tester LDAP **sans attendre la DSI**.

> Ces 4 points rendent la pile **entièrement constructible et démontrable en local** (l'objectif « ◑ l'essentiel constructible en local »), en attendant les éléments DSI pour le « ⚠️ LDAP+MFA et 4D réel ».
