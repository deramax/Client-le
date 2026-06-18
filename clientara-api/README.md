# Portail API — ClienTara

Passerelle entre l'application **ClienTara** et la source des données clients.
Elle cherche un client par **Refnum** ou par **nom**, et renvoie son **dossier complet** :
`{ client, produits[], contrats[] }`.

## Deux modes (variable `DATA_SOURCE` dans `.env`)

| Mode | `DATA_SOURCE` | Source | Usage |
|------|---------------|--------|-------|
| **Démo** | `demo` | le fichier Excel `clients-source.xlsx` (feuilles « BD clients » + « Journal ») | démonstration sur les vraies données |
| **Production** | `production` | le serveur **4D** via son API REST | exploitation réelle |

Dans les deux cas, le format renvoyé à ClienTara est identique.

## Démarrage (5 minutes)

```bash
npm install
cp .env.example .env      # Windows : copy .env.example .env
npm start
```
Puis ouvrir **http://localhost:4000/** et chercher `145238` ou `RAZAFI`.
En mode démo, le portail charge automatiquement les ~650 clients du fichier Excel.

## Endpoints

| Méthode | URL | Rôle |
|--------|-----|------|
| GET | `/health` | Mode actif + nb de clients (démo) |
| GET | `/api/clients/search?q=...` | Recherche par Refnum **ou** nom |
| GET | `/api/clients/:refnum` | Dossier complet d'un client |
| GET | `/api/config` | Mapping et configuration |

## Passer en production (4D)

1. Dans `.env` : `DATA_SOURCE=production`, puis `FOURD_URL`, `FOURD_USER`, `FOURD_PASSWORD`.
2. Remplir `mapping.json` (sections 4D) avec les **vrais noms** de tables/champs 4D.
3. `npm start`.

Détails pas-à-pas dans **Guide_Integration_4D_ClienTara.pdf**.

## Côté ClienTara

L'application (dernière version) a un bouton **« Importer un client »** dans
l'onglet **Demandes ▸ File de traitement** : il interroge ce portail et pré-remplit
automatiquement le formulaire d'une nouvelle requête. L'URL du portail est définie en
haut du script de ClienTara (`CLIENTARA_API`).

## Fichiers

- `server.js` — le portail (mode démo Excel + connecteur 4D + page de test).
- `clients-source.xlsx` — le fichier Excel source (mode démo).
- `mapping.json` — correspondances Excel et 4D (4D à remplir en production).
- `.env.example` — modèle de configuration.

> Le fichier Excel n'est lu qu'en lecture. Ne jamais publier le `.env`.
> En production : compte 4D **lecture seule**, **HTTPS** et un `API_TOKEN`.
