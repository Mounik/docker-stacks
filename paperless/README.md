# Paperless-ngx — Document Management System

Self-hosted document digitization, OCR, and search system. Upload PDFs/scans, run OCR, and full-text search.

## Stack Overview

| Service | Description |
|---------|-------------|
| `paperless` | Main web UI + API |
| `db` | PostgreSQL |
| `broker` | Redis task queue |
| `gotenberg` | PDF conversion |
| `tika` | Content analysis |

## Setup

1. Copy `.env.example` to `.env` and edit values
2. Deploy: `make up STACK=paperless`
3. Access via `PAPERLESS_DOMAIN`

## Uploading Documents

Drop files into the consume folder or upload via web UI:
- Mount `./consume` to ingest via filesystem
- Drag-and-drop in the web UI

## Storage

- `paper_media/`: processed documents
- `paper_data/`: database + index
- `paper_export/`: manual exports
- `paper_consume/`: ingestion inbox
