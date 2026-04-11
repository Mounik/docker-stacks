# 🐳 Docker Stacks

**Production-ready Docker Compose stacks** — Reverse proxy, monitoring, self-hosted apps, security. Plug & play.

Each stack is self-contained with its own README, `.env.example`, and configuration files.

## 📦 Available Stacks

| Stack | Description | Ports |
|-------|-------------|-------|
| [Traefik](./traefik/) | Reverse proxy with auto-SSL (Let's Encrypt) | 80, 443 |
| [Nextcloud](./nextcloud/) | Self-hosted cloud storage & collaboration | 443 |
| [Grafana](./grafana/) | Monitoring dashboard (Grafana + Prometheus + Loki) | 3000, 9090 |
| [Vaultwarden](./vaultwarden/) | Lightweight Bitwarden password manager | 8080 |
| [Portainer](./portainer/) | Docker management UI | 9443 |
| [Gitea](./gitea/) | Self-hosted lightweight Git | 3000, 2222 |
| [Uptime Kuma](./uptime-kuma/) | Uptime monitoring & status page | 3001 |
| [Authelia](./authelia/) | 2FA/SSO authentication portal | 9091 |

## 🚀 Quick Start

```bash
# 1. Clone the repo
git clone https://github.com/Mounik/docker-stacks.git
cd docker-stacks

# 2. Pick a stack
cd traefik/

# 3. Copy and edit environment
cp .env.example .env
nano .env

# 4. Launch
docker compose up -d
```

## 🏗️ Recommended Setup

For a full homelab or small production setup:

1. **Traefik** → reverse proxy (deploy first, handles SSL for everything)
2. **Authelia** → SSO/2FA in front of your services
3. Then add any stack — they're all pre-configured to work with Traefik

```
Internet → Traefik (SSL/routing) → Authelia (auth) → Your services
```

## 🔧 Common Features

- ✅ **Traefik labels** pre-configured on every stack
- ✅ **`.env.example`** with all variables documented
- ✅ **Health checks** where applicable
- ✅ **Persistent volumes** with proper ownership
- ✅ **Restart policies** set to `unless-stopped`
- ✅ **Network isolation** — each stack on its own network
- ✅ **Security hardening** — read-only filesystems, dropped capabilities where possible

## 📁 Structure

```
docker-stacks/
├── traefik/
│   ├── docker-compose.yml
│   ├── .env.example
│   ├── traefik.yml
│   └── README.md
├── nextcloud/
│   ├── docker-compose.yml
│   ├── .env.example
│   └── README.md
├── grafana/
│   ├── docker-compose.yml
│   ├── .env.example
│   ├── prometheus/
│   ├── loki/
│   └── README.md
└── ...
```

## 🤝 Contributing

Found a bug? Have a stack to add? PRs welcome!

1. Fork → Branch → PR
2. Each stack must have: `docker-compose.yml`, `.env.example`, `README.md`
3. Test with `docker compose config` and `docker compose up -d` before submitting

## 📜 License

MIT — Use it however you want. No warranty.

---

**Star ⭐ if you find this useful!**