# Immich — Self-hosted Photo & Video Backup

Self-hosted Google Photos alternative with AI-powered search, facial recognition, and smart albums.

## Stack Overview

| Service | Description |
|---------|-------------|
| `immich-server` | Main Immich API + web UI |
| `immich-machine-learning` | AI face/object recognition |
| `db` | PostgreSQL with pgvecto.rs + Redis |

## Setup

1. Copy `.env.example` to `.env` and edit values
2. Deploy: `make up STACK=immich`
3. Access via `IMMICH_DOMAIN` (or directly on port 2283)

## First Run

After first login, register your admin account. Then download the mobile app (iOS/Android) and point it at your domain.

## Storage

- `immich_uploads`: all photos/videos (grows fast, plan accordingly)
- `immich_model_cache`: downloaded ML models (~1 GB)

## Traefik Labels

Pre-configured for access via `https://IMMICH_DOMAIN` on your Traefik reverse proxy.
