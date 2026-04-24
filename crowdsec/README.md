# CrowdSec — Collaborative IPS

Intrusion Prevention System with community blocklists. Binds to Traefik via a bouncer middleware.

## Setup

1. Copy `.env.example` to `.env`
2. Generate an API key (run once):
   ```bash
   cd crowdsec
   docker compose up -d crowdsec
   docker compose exec crowdsec cscli bouncers add TraefikBouncer
   # Copy the generated key into .env
   ```
3. Deploy: `make up STACK=crowdsec`

## Enable the bouncer on Traefik

After CrowdSec is running, add to `traefik/traefik.yml` under `experimental.plugins`:

```yaml
experimental:
  plugins:
    crowdsec:
      moduleName: "github.com/maxlerebourg/crowdsec-bouncer-traefik-plugin"
      version: "v1.3.5"
```

Then apply the `crowdsec@docker` middleware to any router you want to protect.
