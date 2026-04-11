# Portainer Stack

Docker management UI with Traefik reverse proxy.

## Setup

```bash
# 1. Generate admin password hash
docker run --rm httpd:alpine htpasswd -nbB admin "YOUR_PASSWORD" | cut -d ':' -f 2

# 2. Copy .env and paste the hash
cp .env.example .env
nano .env

# 3. Launch
docker network create proxy 2>/dev/null; docker compose up -d

# 4. Visit https://portainer.yourdomain.com
```

## Note

No admin setup wizard — password is set via `PORTAINER_HASHED_PASSWORD` for security.