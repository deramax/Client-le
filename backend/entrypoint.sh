#!/usr/bin/env sh
set -e

# Wait for PostgreSQL when running against a real DB (DB_HOST set).
if [ -n "$DB_HOST" ]; then
  echo "ClienTara: attente de PostgreSQL sur $DB_HOST:${DB_PORT:-5432}..."
  python - <<'PY'
import os, sys, time
import psycopg
cfg = dict(host=os.environ.get("DB_HOST", "db"),
           port=int(os.environ.get("DB_PORT", "5432")),
           user=os.environ.get("DB_USER", "clientara"),
           password=os.environ.get("DB_PASSWORD", "clientara"),
           dbname=os.environ.get("DB_NAME", "clientara"))
for _ in range(60):
    try:
        psycopg.connect(connect_timeout=2, **cfg).close()
        print("ClienTara: PostgreSQL prêt.")
        sys.exit(0)
    except Exception:
        time.sleep(1)
print("ClienTara: PostgreSQL indisponible après 60s.", file=sys.stderr)
sys.exit(1)
PY
fi

echo "ClienTara: migrations..."
python manage.py migrate --noinput

if [ "${SEED_DEMO:-true}" = "true" ]; then
  echo "ClienTara: chargement des données de démonstration..."
  python manage.py seed_demo || echo "ClienTara: seed ignoré (déjà présent ?)"
fi

echo "ClienTara: collecte des fichiers statiques..."
python manage.py collectstatic --noinput >/dev/null 2>&1 || true

exec "$@"
