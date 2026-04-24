# Docker Stacks
![CI](https://github.com/Mounik/docker-stacks/actions/workflows/validate.yml/badge.svg)

**Production-ready Docker Compose stacks** — Reverse proxy, monitoring, self-hosted apps, security. Plug & play.

Each stack is self-contained with its own README, `.env.example`, and configuration files.

## Available Stacks

| Stack | Description | Ports |
|-------|-------------|-------|
| [Traefik](./traefik/) | Reverse proxy with auto-SSL (Let's Encrypt) | 80, 443 |
| [Authelia](./authelia/) | 2FA/SSO authentication portal | 9091 |
| [Nextcloud](./nextcloud/) | Self-hosted cloud storage & collaboration | 443 |
| [Grafana](./grafana/) | Monitoring dashboard (Grafana + Prometheus + Loki + Promtail) | 3000, 9090 |
| [Vaultwarden](./vaultwarden/) | Lightweight Bitwarden password manager | 8080 |
| [Portainer](./portainer/) | Docker management UI | 9443 |
| [Gitea](./gitea/) | Self-hosted lightweight Git | 3000, 2222 |
| [Uptime Kuma](./uptime-kuma/) | Uptime monitoring & status page | 3001 |
| [Immich](./immich/) | Self-hosted photo & video backup (Google Photos alt) | 2283 |
| [Paperless-ngx](./paperless/) | Document digitization, OCR & full-text search | 8000 |
| [Jellyfin](./jellyfin/) | Open-source media server (movies, TV, music) | 8096 |
| [Backup](./backup/) | Automated volume backups | - |

## Quick Start

```bash
# 1. Clone the repo
git clone https://github.com/Mounik/docker-stacks.git
cd docker-stacks

# 2. Initialize (creates proxy network + copies .env files)
make init

# 3. Edit .env files with your domain and secrets
#    See SECRETS.md for generating secure values
nano traefik/.env
nano authelia/.env

# 4. Start all stacks
make up-all

# Or start individually
make up STACK=traefik
```

## Recommended Setup

For a full homelab or small production setup:

1. **Traefik** — reverse proxy (deploy first, handles SSL for everything)
2. **Authelia** — SSO/2FA in front of your services
3. Then add any stack — they're all pre-configured to work with Traefik
4. **Backup** — automated scheduled backups of all volumes

```
Internet -> Traefik (SSL/routing) -> Authelia (auth) -> Your services
```

## Common Features

- **Traefik labels** pre-configured on every stack
- **`.env.example`** with all variables documented
- **Health checks** on all services
- **Persistent volumes** with proper ownership
- **Restart policies** set to `unless-stopped`
- **Network isolation** — each stack on its own network
- **Security hardening** — read-only filesystems, dropped capabilities where possible

## Updating & Rollback

```bash
# Update a single stack
make update STACK=nextcloud

# Update all stacks (one at a time)
for stack in traefik authelia nextcloud grafana vaultwarden portainer gitea uptime-kuma; do
  make update STACK=$stack
done

# Rollback if something breaks
cd nextcloud
docker compose down
# Edit docker-compose.yml to pin previous image tag
docker compose up -d
```

Before updating, always:

1. Check the upstream changelog for breaking changes
2. Run `make backup` or ensure the backup stack is running
3. Update one stack at a time, verify it works

See [SECRETS.md](./SECRETS.md) for secret management best practices.

## Structure

```
docker-stacks/
├── traefik/
│   ├── docker-compose.yml
│   ├── .env.example
│   ├── traefik.yml
│   └── README.md
├── authelia/
│   ├── docker-compose.yml
│   ├── .env.example
│   ├── config/
│   │   ├── configuration.yml
│   │   └── users_database.yml
│   └── README.md
├── grafana/
│   ├── docker-compose.yml
│   ├── .env.example
│   ├── prometheus/
│   ├── loki/
│   ├── promtail/
│   └── README.md
├── backup/
│   ├── docker-compose.yml
│   ├── .env.example
│   └── README.md
└── ...
```

## Contributing

Found a bug? Have a stack to add? PRs welcome!

1. Fork -> Branch -> PR
2. Each stack must have: `docker-compose.yml`, `.env.example`, `README.md`
3. Test with `make validate` before submitting

## License

MIT — Use it however you want. No warranty.