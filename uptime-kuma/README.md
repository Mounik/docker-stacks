# Uptime Kuma Stack

Beautiful uptime monitoring with status pages.

## Setup

```bash
docker network create proxy 2>/dev/null
cp .env.example .env && nano .env
docker compose up -d
# Visit https://status.yourdomain.com
```

## Features

- ✅ HTTP(s), TCP, DNS, ping monitoring
- ✅ Push notifications (Telegram, Discord, Slack, email...)
- ✅ Status pages
- ✅ Certificate monitoring