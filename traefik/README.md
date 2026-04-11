# Traefik Reverse Proxy Stack

Production-ready Traefik v3 with automatic Let's Encrypt SSL.

## Features

- ✅ Automatic HTTPS via Let's Encrypt
- ✅ HTTP→HTTPS redirect
- ✅ Docker provider (auto-discovery)
- ✅ Secure dashboard with basic auth
- ✅ Hardened container (read-only, dropped caps)

## Setup

```bash
# 1. Create the external network
docker network create proxy

# 2. Copy and edit environment
cp .env.example .env
nano .env

# 3. Create ACME storage file
touch acme.json && chmod 600 acme.json

# 4. Generate dashboard password
htpasswd -nb admin YOUR_PASSWORD
# Copy the output to TRAEFIK_DASHBOARD_AUTH in .env
# Note: escape $ with $$ in .env

# 5. Launch
docker compose up -d
```

## Adding Services

Any container on the `proxy` network with Traefik labels will be auto-discovered:

```yaml
services:
  myapp:
    image: myapp:latest
    networks:
      - proxy
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.myapp.rule=Host(`myapp.yourdomain.com`)"
      - "traefik.http.routers.myapp.tls.certresolver=letsencrypt"
      - "traefik.http.services.myapp.loadbalancer.server.port=8080"
```

## Ports

| Port | Purpose |
|------|---------|
| 80 | HTTP (redirects to HTTPS) |
| 443 | HTTPS |
| 8080 | Traefik dashboard |

## Troubleshooting

```bash
# Check logs
docker compose logs -f traefik

# Verify config
docker compose config

# Test ACME
docker compose exec traefik cat /acme.json
```