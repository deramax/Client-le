# Import PostgreSQL — ClienTara

Scripts pour créer la base et importer les données dans **votre PostgreSQL local**.
Le schéma est généré à partir des migrations Django (16 tables) — il correspond
donc exactement à ce qu'attend l'application.

| Fichier | Contenu |
|---|---|
| `00_create_database.sql` | Crée le rôle `clientara` + la base `clientara` (à lancer en superutilisateur) |
| `clientara_schema.sql` | Schéma seul (16 tables, index, contraintes) |
| `clientara_data.sql` | Données seules (1463 `INSERT` : 664 demandes, 640 clients, 73 référentiels, 5 rôles, admin) |
| `clientara_full.sql` | **Schéma + données** en un seul fichier (avec `DROP ... IF EXISTS` en tête) |

Compte applicatif après import : **admin / Clientara2026!**

---

## Option A — Import complet en une commande (recommandé)

```bash
# 1) créer le rôle + la base (superutilisateur)
psql -U postgres -f 00_create_database.sql

# 2) importer schéma + données
psql -U clientara -d clientara -f clientara_full.sql
```

> `clientara_full.sql` commence par `DROP ... IF EXISTS` : un ré-import repart
> donc d'une base propre (idéal pour réinitialiser le jeu de démonstration).

## Option B — Schéma puis données séparément

```bash
psql -U postgres -c "CREATE DATABASE clientara OWNER clientara;"
psql -U clientara -d clientara -f clientara_schema.sql
psql -U clientara -d clientara -f clientara_data.sql
```

## Option C — Via Django (reste synchronisé avec le code)

```bash
cd backend
export DB_HOST=127.0.0.1 DB_PORT=5432 DB_NAME=clientara DB_USER=clientara DB_PASSWORD=clientara
python manage.py migrate      # crée les tables
python manage.py seed_demo    # importe les données de démonstration
```

---

## Vérification

```bash
psql -U clientara -d clientara -c "
  SELECT 'demandes', count(*) FROM core_demande
  UNION ALL SELECT 'clients', count(*) FROM core_clientrecord
  UNION ALL SELECT 'référentiels', count(*) FROM core_refitem;"
```

Attendu : 664 demandes · 640 clients · 73 référentiels.

> Les fichiers `*_full`/`*_data` utilisent `--no-owner` : ils s'importent sous
> n'importe quel rôle. Adaptez le mot de passe du rôle `clientara` avant toute
> mise en production.
