# Jellyfin — Media Server

Open-source media server for your movies, series, music, and photos. Emby/Plex alternative.

## Stack Overview

| Service | Description |
|---------|-------------|
| `jellyfin` | Media server + web player + DLNA |

## Setup

1. Copy `.env.example` to `.env` and edit values
2. Set `JELLYFIN_MEDIA_PATH` to the absolute path of your media folder on the host
3. Deploy: `make up STACK=jellyfin`
4. Access via `JELLYFIN_DOMAIN`

## Initial Setup Wizard

- Choose server language
- Add libraries pointing to `/media` (the host folder mounted inside the container)
- Configure metadata languages and scrapers (TMDB, TheTVDB)

## Hardware Transcoding (Optional)

To enable GPU transcoding (VAAPI, NVENC, QuickSync), add the corresponding device mounts in `docker-compose.yml`:

```yaml
    devices:                          # Linux VAAPI
      - /dev/dri:/dev/dri
```

Or for NVIDIA:

```yaml
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
```

## Clients

- Web: via Traefik at `JELLYFIN_DOMAIN`
- Android/iOS: Jellyfin apps
- TV: Jellyfin for Android TV / Roku / LG webOS / Samsung Tizen
