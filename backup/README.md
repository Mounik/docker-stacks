# Automated Backup Stack

Automatic volume backup using [docker-volume-backup](https://github.com/offen/docker-volume-backup).

## Features

- Scheduled backups (cron, default: daily at 2 AM)
- Local archive or S3-compatible storage
- Configurable retention (default: 7 days)
- Backs up all stack data volumes

## Setup

```bash
# 1. Copy and edit environment
cp .env.example .env
nano .env

# 2. Create local archive directory
mkdir -p backups

# 3. Launch (stacks must be running for volumes to exist)
docker compose up -d
```

## Restore

```bash
# List available backups
ls -la backups/

# Extract a backup
tar xzf backups/homelab-backup-2025-01-01T02-00-00.tar.gz -C /tmp/restore

# Copy data back to volume
docker cp /tmp/restore/nextcloud/. <container>:/var/www/html/
```

## Adding More Volumes

Edit `docker-compose.yml` and mount additional volumes under `/backup/target/`:

```yaml
volumes:
  - my_new_volume:/backup/target/my-service:ro
```