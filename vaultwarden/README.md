# Vaultwarden Stack

Lightweight Bitwarden-compatible password manager.

## Features

- ✅ Full Bitwarden API compatibility
- ✅ WebSocket notifications support
- ✅ Admin panel at `/admin`
- ✅ SMTP email for invitations & 2FA
- ✅ Auto-SSL via Traefik

## Setup

```bash
# 1. Ensure proxy network exists
docker network create proxy

# 2. Copy and edit environment
cp .env.example .env
nano .env

# 3. Generate admin token
echo "VW_ADMIN_TOKEN=$(openssl rand -base64 48)" >> .env

# 4. Launch
docker compose up -d

# 5. Visit https://vault.yourdomain.com
# Create your account, then disable registration in .env:
#   SIGNUPS_ALLOWED=false
```

## Security Hardening

After creating your account, add to `.env`:
```
SIGNUPS_ALLOWED=false
INVITATIONS_ALLOWED=false
```

## Backup

```bash
# SQLite backup
docker compose exec vaultwarden sqlite3 /data/db.sqlite3 ".backup '/data/db-backup.sqlite3'"
docker cp vaultwarden:/data/db-backup.sqlite3 ./vaultwarden_backup_$(date +%F).sqlite3
```