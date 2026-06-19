-- ============================================================
--  ClienTara — création du rôle applicatif et de la base
--  À exécuter en tant que SUPERUTILISATEUR PostgreSQL, ex. :
--      psql -U postgres -f 00_create_database.sql
--  Idempotent : peut être relancé sans erreur.
-- ============================================================

-- 1) Rôle applicatif (adapter le mot de passe en production)
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'clientara') THEN
    CREATE ROLE clientara LOGIN PASSWORD 'clientara';
  END IF;
END $$;

-- 2) Base de données (créée seulement si absente)
SELECT 'CREATE DATABASE clientara OWNER clientara'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'clientara')\gexec
