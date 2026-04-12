# Secrets Management Guide

All stacks use `.env` files for configuration. **Never commit `.env` files** — they are excluded via `.gitignore`.

## Generating Secure Secrets

Use these commands to generate cryptographically secure values:

```bash
# Hex secret (JWT, session keys, etc.)
openssl rand -hex 32

# Base64 token (admin tokens, API keys)
openssl rand -base64 48

# Argon2id password hash (Authelia users)
docker run --rm authelia/authelia:4.38 authelia crypto hash generate argon2id --password 'YOUR_PASSWORD'

# htpasswd basic auth (Traefik dashboard)
htpasswd -nb admin YOUR_PASSWORD
# Escape $ with $$ in .env files

# bcrypt hash (Portainer admin)
docker run --rm httpd:alpine htpasswd -nbB admin "YOUR_PASSWORD" | cut -d ':' -f 2
```

## Production Recommendations

For production deployments, consider using Docker Secrets instead of `.env` files:

```yaml
services:
  db:
    environment:
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
    secrets:
      - db_password

secrets:
  db_password:
    file: ./secrets/db_password.txt
```

Alternatively, use an external secret manager:

- **HashiCorp Vault** — full-featured secret management
- **SOPS + age/GPG** — encrypt `.env` files in git
- **Docker Swarm secrets** — native secrets for Swarm mode

## Checklist

- [ ] All `change_me` and default passwords in `.env.example` replaced
- [ ] `SIGNUPS_ALLOWED=false` set in Vaultwarden after initial setup
- [ ] `INVITATIONS_ALLOWED=false` set in Vaultwarden if not needed
- [ ] SMTP credentials are app-specific passwords (not main account)
- [ ] `.env` files have restricted permissions: `chmod 600 .env`
- [ ] ACME file has restricted permissions: `chmod 600 acme.json`