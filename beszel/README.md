# Beszel — Lightweight System Monitoring

Minimal agent/server monitoring dashboard. Track CPU, RAM, disk, network, and processes across all your hosts. Modern alternative to Netdata.

## Setup

1. Copy `.env.example` to `.env`
2. Deploy: `make up STACK=beszel`
3. Access via `BESZEL_DOMAIN`

## Add a New Host

On the remote host, run:

```bash
docker run -d \
  --name beszel-agent \
  --restart unless-stopped \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -e KEY=YOUR_HOST_PUBLIC_KEY \
  -p 45876:45876 \
  henrygd/beszel-agent:0.11.0
```

Then press "Add System" in the Beszel hub.
