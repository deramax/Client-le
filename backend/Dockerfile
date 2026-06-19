# ClienTara backend — Django + DRF
FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

# System libs: build tools + LDAP headers (so requirements-ldap can compile
# python-ldap). LDAP stays disabled at runtime unless LDAP_ENABLED=true.
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential libldap2-dev libsasl2-dev libpq5 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements-ldap.txt ./
RUN pip install -r requirements.txt && pip install -r requirements-ldap.txt

COPY . .
RUN chmod +x entrypoint.sh

EXPOSE 8000
ENTRYPOINT ["./entrypoint.sh"]
CMD ["gunicorn", "clientara.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3", "--timeout", "120"]
