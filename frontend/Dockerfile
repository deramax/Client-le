# ---- Stage 1: build the Vite/React app ----
FROM node:20-alpine AS build
WORKDIR /app

# Install deps first (better layer caching)
COPY package.json package-lock.json* ./
RUN npm install

# Build
COPY . .
# VITE_API_URL is baked at build time; defaults to /api (served behind nginx proxy)
ARG VITE_API_URL=/api
ENV VITE_API_URL=$VITE_API_URL
RUN npm run build

# ---- Stage 2: serve with nginx ----
FROM nginx:1.27-alpine AS serve

# SPA + /api proxy config (BACKEND_HOST is templated at container start)
COPY nginx.conf /etc/nginx/templates/default.conf.template

# Proxy target is configurable; defaults to the docker-compose service name.
ENV BACKEND_HOST=backend
ENV BACKEND_PORT=8000

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
# nginx:alpine entrypoint runs envsubst over /etc/nginx/templates/*.template
CMD ["nginx", "-g", "daemon off;"]
