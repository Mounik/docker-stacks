# NetBox — IPAM & DCIM

Complete network infrastructure and data center management. Tracks IPs, racks, devices, cables, VLANs.

## Setup

1. Copy `.env.example` to `.env`
2. Deploy: `make up STACK=netbox`
3. Create a superuser:
   ```bash
   docker compose exec netbox /opt/netbox/netbox/manage.py createsuperuser
   ```

## Usage

- **IPAM**: manage IP addresses, prefixes, VLANs, VRFs
- **DCIM**: racks, devices, cables, power
- **Circuits**: provider circuits
- **Contacts**: organizations and contacts
- **Tenancy**: multi-tenant support

## Integration

Connect to NAPALM for automated device discovery and configuration backup.
