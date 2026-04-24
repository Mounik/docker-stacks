# Docker Registry — Private Image Registry

Host your own Docker images securely. Includes a web UI for browsing.

## Setup

1. Generate a htpasswd credentials file:
   ```bash
   mkdir -p registry/auth
   htpasswd -Bbn admin YourPassword > registry/auth/htpasswd
   ```
2. Copy `.env.example` to `.env`
3. Deploy: `make up STACK=registry`

## Push an Image

```bash
docker tag my-image:latest registry.yourdomain.com/my-image:latest
docker login registry.yourdomain.com
docker push registry.yourdomain.com/my-image:latest
```

## Web UI

Open `REGISTRY_UI_DOMAIN` to browse repositories and tags.
