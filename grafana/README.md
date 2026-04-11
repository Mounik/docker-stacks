# Grafana Monitoring Stack

Full observability stack: Grafana + Prometheus + Loki + Node Exporter + cAdvisor.

## Features

- ✅ Grafana 11.4 dashboards
- ✅ Prometheus metrics collection (30d retention)
- ✅ Loki log aggregation
- ✅ Node Exporter (system metrics)
- ✅ cAdvisor (container metrics)
- ✅ Auto-provisioned datasources
- ✅ Alert rules for CPU, disk, memory
- ✅ Traefik reverse proxy ready

## Setup

```bash
# 1. Ensure proxy network exists
docker network create proxy

# 2. Copy and edit environment
cp .env.example .env
nano .env

# 3. Launch
docker compose up -d

# 4. Visit https://grafana.yourdomain.com
# Login with GF_ADMIN_USER / GF_ADMIN_PASSWORD from .env
```

## First Dashboard

After login:
1. Go to Dashboards → Import
2. Import ID **1860** (Node Exporter Full) — best community dashboard
3. Import ID **11600** (Dashboard for cAdvisor)

## Add More Targets

Edit `prometheus/prometheus.yml` to scrape additional services:

```yaml
- job_name: myapp
  static_configs:
    - targets: ["myapp:8080"]
```

## Backup

```bash
# Grafana data
docker compose exec grafana grafana-cli admin export /tmp/grafana-export
docker cp grafana:/tmp/grafana-export ./grafana-backup
```