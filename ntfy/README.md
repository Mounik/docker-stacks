# ntfy — Push Notifications

Lightweight self-hosted notification server. Subscribe via mobile app or curl.

## Setup

1. Copy `.env.example` to `.env`
2. Deploy: `make up STACK=ntfy`
3. Access via `NTFY_DOMAIN`

## Send a Notification

```bash
curl -d "Backup completed" https://YOUR_DOMAIN/backup
```

## Grafana Alertmanager Integration

In `grafana/provisioning/alerting/alertmanager.yml`:

```yaml
receivers:
  - name: ntfy
    webhook_configs:
      - url: https://YOUR_DOMAIN/grafana
```

## Mobile App

Download ntfy (iOS/Android) and subscribe to your topics.
