# ClienTara — Frontend

React + Vite single-page app for the ClienTara customer-retention platform.
Faithful port of the legacy single-file vanilla-JS app (`../ClienTara.html`).

## Stack

- Vite + React 18
- react-router-dom v6
- chart.js + react-chartjs-2
- Plain CSS design system (`src/styles/legacy.css`, 4 themes)

## Development

```bash
npm install
npm run dev
```

The dev server runs on http://localhost:5173 and proxies `/api` to the Django
backend (default `http://localhost:8000`, override with `VITE_DEV_PROXY`).

## Environment

| Variable        | Default | Description                                  |
| --------------- | ------- | -------------------------------------------- |
| `VITE_API_URL`  | `/api`  | Base URL for all API calls (baked at build). |
| `VITE_DEV_PROXY`| `http://localhost:8000` | Dev-only proxy target for `/api`. |

JWT tokens are stored in `localStorage` under `cta_access` / `cta_refresh`.
The selected theme is persisted under `cta_theme` (default `clair`).

## Build

```bash
npm run build      # outputs to dist/
npm run preview    # serve the production build locally
```

## Docker

Multi-stage build (Node build -> nginx serve). The nginx layer proxies `/api`
to the backend; the target host/port are configurable:

```bash
docker build -t clientara-frontend .
docker run -p 8080:80 -e BACKEND_HOST=backend -e BACKEND_PORT=8000 clientara-frontend
```

`BACKEND_HOST` defaults to `backend` (the docker-compose service name) and
`BACKEND_PORT` to `8000`.

## Structure

```
src/
  api/         fetch wrapper (JWT, refresh-on-401)
  auth/        AuthContext + route guards
  components/  layout (Sidebar, Topbar), Modal, Toasts, charts...
  views/       Dashboard, Demandes, Clients, Rapports, Notifications,
               Audit, Parametres, and the auth screens
  lib/         business helpers ported from ClienTara.html
  styles/      legacy.css design system
```
