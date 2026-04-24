# Prerequisites & Setup Guide

> **Read this before deploying!** This repository contains **23 production-ready Docker Compose stacks**. A full deployment requires a properly configured host.

---

## 1. Operating System

| OS | Support | Notes |
|---|---|---|
| **Linux** (Debian, Ubuntu, Arch, Fedora) | Recommended | Native Docker support, full feature parity |
| **WSL2** (Windows) | Supported | Use Docker Desktop or Docker Engine inside WSL |
| **macOS** | Limited | Port 53 (AdGuard) and some host-level monitoring won't work |
| **Cloud VPS** (OVH, Hetzner, AWS, GCP) | Ideal | Static IP, good bandwidth, runs 24/7 |

---

## 2. Required Software

Install these before cloning the repository:

```bash
# Docker Engine + Docker Compose plugin
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
newgrp docker

# Git
sudo apt update && sudo apt install -y git

# Make
sudo apt install -y make

# htpasswd (for Traefik and Registry basic auth)
sudo apt install -y apache2-utils
```

**Verify installation:**

```bash
docker --version      # >= 24.0
docker compose version  # >= 2.20
git --version         # any recent
make --version        # any recent
```

---

## 3. Network & DNS Requirements

| Requirement | Why |
|---|---|
| **A domain name** | Every stack uses `${DOMAIN}` variables (e.g., `traefik.yourdomain.com`) |
| **Wildcard DNS** `*.yourdomain.com` → Server IP | Avoids creating 20+ individual A records |
| **Ports 80 & 443 open** | Traefik needs them for Let's Encrypt HTTP challenge |

**Example DNS records:**

```
A     yourdomain.com        → YOUR_SERVER_IP
A     *.yourdomain.com      → YOUR_SERVER_IP   (wildcard)
```

**Additional ports (if used outside Traefik):**

| Stack | Port | Protocol |
|---|---|---|
| AdGuard Home | 53 | TCP + UDP |
| Gitea | 2222 | TCP (SSH) |
| Syncthing | 22000 | TCP |
| Syncthing | 21027 | UDP (discovery) |

---

## 4. Docker Network

The `proxy` network is created automatically by `make init`, but you can verify:

```bash
docker network inspect proxy || docker network create proxy
```

All stacks connect to this network so Traefik can route traffic to them.

---

## 5. System Resources

If you plan to run **all 23 stacks** simultaneously:

| Resource | Minimum | Recommended |
|---|---|---|
| **RAM** | 12 GB | 16 GB+ |
| **CPU** | 4 cores | 6–8 cores |
| **Storage** | 100 GB | 250 GB+ SSD |
| **Internet** | 100 Mbps | 1 Gbps (for media streaming) |

> 💡 **Tip**: You don't need to run everything at once. Pick 5–7 stacks based on your actual needs. Each stack is independent.

---

## 6. Initial Configuration Workflow

```bash
# 1. Clone
git clone https://github.com/Mounik/docker-stacks.git
cd docker-stacks

# 2. Initialize (creates proxy network + copies .env files)
make init

# 3. Configure EVERY .env file
# Replace all placeholder values:
#   yourdomain.com    → your real domain
#   ChangeMeNow!      → strong passwords
#   change_me_*       → generated secrets (see SECRETS.md)
nano traefik/.env authelia/.env gitea/.env ...

# 4. Start stacks in order
make up STACK=traefik      # always first
make up STACK=authelia     # authentication
# ... then any other stack
```

---

## 7. Stack-Specific Prerequisites

| Stack | Special Requirement |
|---|---|
| **Registry** | Generate `htpasswd` file BEFORE first start: `htpasswd -Bbn admin PASS > registry/auth/htpasswd` |
| **Woodpecker CI** | Create an OAuth App in Gitea FIRST, then fill Client ID/Secret in `.env` |
| **CrowdSec** | Traefik must log accesses to a file. Read `crowdsec/README.md` for plugin setup. |
| **AdGuard** | Port 53 requires root privileges on the host. Won't work on macOS/WSL without hack. |
| **Headscale** | For DERP relay (NAT traversal), you also need Tailscale's official DERP servers or host your own. |
| **Syncthing** | Needs port forwarding on your router if nodes are on different networks. |
| **Gitea** | Port 2222 must be free for SSH clone support. |

---

## 8. Recommended Deployment Order

```bash
# Infrastructure (required for everything else)
make up STACK=traefik
make up STACK=authelia

# Management & monitoring
make up STACK=portainer
make up STACK=dozzle
make up STACK=grafana
make up STACK=beszel
make up STACK=uptime-kuma

# Development
make up STACK=gitea
make up STACK=registry
make up STACK=woodpecker-ci

# User-facing apps (choose what you need)
make up STACK=nextcloud
make up STACK=immich
make up STACK=paperless
make up STACK=jellyfin
make up STACK=vaultwarden
make up STACK=syncthing

# Security & networking
make up STACK=crowdsec
make up STACK=headscale

# Utilities
make up STACK=adguard
make up STACK=ntfy
make up STACK=netbox
make up STACK=it-tools
make up STACK=backup
```

---

## 9. Troubleshooting Quick Checks

```bash
# Docker daemon running?
sudo systemctl status docker

# Proxy network exists?
docker network ls | grep proxy

# Can resolve your domain?
nslookup traefik.yourdomain.com

# Ports 80/443 available?
sudo ss -tlnp | grep -E ':80|:443'

# Enough disk space?
df -h /
```

---

See also: [SECRETS.md](./SECRETS.md) for generating secure passwords and keys.
