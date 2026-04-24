# Woodpecker CI — Lightweight CI/CD

CI/CD engine that integrates natively with Gitea. Self-hosted, small footprint.

## Setup

1. **Create an OAuth App in Gitea**:
   - Gitea Admin > Applications > OAuth2 Applications
   - Redirect URI: `https://ci.yourdomain.com/authorize`
   - Copy Client ID and Client Secret

2. Copy `.env.example` to `.env` and fill values
3. Deploy: `make up STACK=woodpecker-ci`

## First Run

Sign in via Gitea OAuth, and Woodpecker will list your repositories automatically.
