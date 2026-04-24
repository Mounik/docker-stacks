# Syncthing — File Synchronization

Peer-to-peer file synchronization. Great for syncing large folders between machines without going through a cloud.

## Setup

1. Copy `.env.example` to `.env`
2. Set `SYNCTHING_DATA_PATH` to an existing host folder
3. Deploy: `make up STACK=syncthing`
4. Access the GUI via `SYNCTHING_DOMAIN` (port 8384)

## Usage

- Add a remote device by sharing device IDs
- Create folders and choose which peers sync them
- Ignore patterns supported (`.stignore`)

## Discovery

Ports 22000 and 21027 are used for device discovery and sync. The GUI itself goes through Traefik.
