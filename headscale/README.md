# Headscale — Self-hosted Tailscale Control Server

Host your own WireGuard control plane. Manage devices via ACLs without relying on Tailscale cloud.

## Setup

1. Copy `.env.example` to `.env`
2. Edit `config.yaml` and set `server_url` to your domain
3. Deploy: `make up STACK=headscale`
4. Create a user:
   ```bash
   docker compose exec headscale headscale users create myuser
   ```

## Register a Node

1. Generate a pre-auth key:
   ```bash
   docker compose exec headscale headscale preauthkeys create -u myuser -e 24h
   ```
2. On the node:
   ```bash
   sudo tailscale up --login-server https://YOUR_DOMAIN --auth-key YOUR_KEY
   ```
