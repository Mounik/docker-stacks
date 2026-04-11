# Gitea Stack

Self-hosted lightweight Git service with PostgreSQL backend.

## Features

- ✅ Gitea 1.22 (lightweight GitHub alternative)
- ✅ PostgreSQL 16 backend
- ✅ SSH on port 2222 (doesn't conflict with host SSH)
- ✅ Auto-SSL via Traefik
- ✅ Network isolated

## Setup

```bash
# 1. Ensure proxy network exists
docker network create proxy

# 2. Copy and edit environment
cp .env.example .env
nano .env

# 3. Launch
docker compose up -d

# 4. Visit https://git.yourdomain.com
# First user becomes admin automatically.
```

## SSH Configuration

To push via SSH, configure your `~/.ssh/config`:

```
Host git.yourdomain.com
  Port 2222
  User git
  IdentityFile ~/.ssh/id_ed25519
```

## Backup

```bash
# Full backup
docker compose exec gitea gitea dump -c /data/gitea/conf/app.ini
# Find the dump in /data/gitea/dumps inside the container volume
```