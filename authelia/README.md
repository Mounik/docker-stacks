# Authelia Stack

SSO & 2FA authentication portal. Protects all your services behind one login.

## Features

- ✅ Single Sign-On for all your services
- ✅ 2FA (TOTP, WebAuthn)
- ✅ Traefik forward-auth middleware ready
- ✅ SQLite storage (lightweight)
- ✅ SMTP notifications

## Setup

```bash
# 1. Generate secrets
openssl rand -hex 32  # run 3 times for JWT, session, storage keys

# 2. Copy and edit environment
cp .env.example .env
nano .env

# 3. Generate password hash for users_database.yml
docker run --rm authelia/authelia:4.38 authelia crypto hash generate argon2id --password 'YOUR_PASSWORD'
# Replace the hash in config/users_database.yml

# 4. Edit configuration.yml
nano config/configuration.yml
# Replace yourdomain.com with your actual domain

# 5. Launch
docker network create proxy 2>/dev/null
docker compose up -d
```

## Protecting Services

Add the `authelia` middleware to any Traefik router:

```yaml
labels:
  - "traefik.http.routers.myservice.middlewares=authelia@docker"
```

Users will be redirected to Authelia for authentication before accessing the service.

## Adding Users

Edit `config/users_database.yml` and generate password hashes:

```bash
docker run --rm authelia/authelia:4.38 authelia crypto hash generate argon2id --password 'PASSWORD'
```