# Nextcloud Stack

Full Nextcloud setup with PostgreSQL and Redis, behind Traefik reverse proxy.

## Features

- ✅ Nextcloud 29 (Apache)
- ✅ PostgreSQL 16 for performance
- ✅ Redis 7 for caching
- ✅ Auto-SSL via Traefik
- ✅ WebDAV redirect (.well-known)
- ✅ Health checks on DB & Redis
- ✅ Network isolation (nextcloud only accessible via proxy)

## Setup

```bash
# 1. Ensure Traefik proxy network exists
docker network create proxy

# 2. Copy and edit environment
cp .env.example .env
nano .env

# 3. Generate strong passwords!
# Example: openssl rand -base64 32

# 4. Launch
docker compose up -d

# 5. Visit https://cloud.yourdomain.com
```

## Post-Install

After first login, go to Settings → Overview and fix any warnings:
- Add cron job: `docker compose exec nextcloud php occ background:cron`
- Enable recommended apps
- Configure email server

## Backup

```bash
# Full backup
docker compose exec db pg_dump -U nextcloud nextcloud > nextcloud_db.sql
tar czf nextcloud_data.tar.gz -C /var/lib/docker/volumes/nextcloud_nextcloud_data/_data .

# Restore
cat nextcloud_db.sql | docker compose exec -T db psql -U nextcloud nextcloud
```

## Performance Tips

- Enable Redis caching in `config.php`
- Set `PHP_MEMORY_LIMIT=512M` minimum
- Use `PHP_UPLOAD_LIMIT=10G` for large files
- Consider adding OnlyOffice or Collabora for document editing