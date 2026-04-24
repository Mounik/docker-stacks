# AdGuard Home — DNS Recursor & Blocker

DNS server with ad blocking, parental controls, and DNS-over-HTTPS. Replaces Pi-hole.

## Setup

1. Copy `.env.example` to `.env`
2. Deploy: `make up STACK=adguard`
3. Access the setup wizard at `ADGUARD_DOMAIN` (initial admin on `:3002`)
4. Configure your router/devices to use this IP as DNS

## Useful Setup Tips

- Upstream DNS: set to Cloudflare (`1.1.1.1`), Quad9 (`9.9.9.9`), or your ISP
- Blocklists: add `StevenBlack` and `AdAway`
- DNS-over-HTTPS: enable for encrypted DNS queries

## Initial Admin

The container exposes port `3002` for the setup wizard _once_. After that, use port `80` (via Traefik).
