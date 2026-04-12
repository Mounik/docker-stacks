STACKS := traefik authelia nextcloud grafana vaultwarden portainer gitea uptime-kuma
PROXY_NETWORK := proxy

.PHONY: init up down ps logs validate help

help:
	@echo "Docker Stacks - Available commands:"
	@echo ""
	@echo "  make init          Create proxy network + copy .env files"
	@echo "  make up STACK=foo  Start a specific stack"
	@echo "  make up-all        Start all stacks in order"
	@echo "  make down STACK=foo   Stop a specific stack"
	@echo "  make down-all      Stop all stacks"
	@echo "  make ps            Show running containers for all stacks"
	@echo "  make logs STACK=foo  Tail logs for a stack"
	@echo "  make validate      Validate all docker-compose files"
	@echo "  make backup        Run backup for all stacks"
	@echo "  make update        Pull latest images for a stack"
	@echo ""

init:
	@docker network inspect $(PROXY_NETWORK) >/dev/null 2>&1 || \
		(echo "Creating $(PROXY_NETWORK) network..." && docker network create $(PROXY_NETWORK))
	@for stack in $(STACKS); do \
		if [ -f "$$stack/.env.example" ] && [ ! -f "$$stack/.env" ]; then \
			echo "Copying $$stack/.env.example -> $$stack/.env"; \
			cp $$stack/.env.example $$stack/.env; \
		fi; \
	done
	@if [ -f "traefik/.env" ] && [ ! -f "traefik/acme.json" ]; then \
		echo "Creating traefik/acme.json"; \
		touch traefik/acme.json && chmod 600 traefik/acme.json; \
	fi
	@echo "Done! Edit .env files in each stack before starting."

up:
	@if [ -z "$(STACK)" ]; then echo "Usage: make up STACK=<name>"; exit 1; fi
	@cd $(STACK) && docker compose up -d

up-all:
	@for stack in $(STACKS); do \
		echo "=== Starting $$stack ==="; \
		cd $$stack && docker compose up -d && cd ..; \
	done

down:
	@if [ -z "$(STACK)" ]; then echo "Usage: make down STACK=<name>"; exit 1; fi
	@cd $(STACK) && docker compose down

down-all:
	@for stack in $(STACKS); do \
		echo "=== Stopping $$stack ==="; \
		cd $$stack && docker compose down && cd ..; \
	done

ps:
	@for stack in $(STACKS); do \
		echo "=== $$stack ==="; \
		cd $$stack && docker compose ps && cd ..; \
	done

logs:
	@if [ -z "$(STACK)" ]; then echo "Usage: make logs STACK=<name>"; exit 1; fi
	@cd $(STACK) && docker compose logs -f

validate:
	@for stack in $(STACKS); do \
		echo "Validating $$stack..."; \
		cd $$stack && docker compose config -q && cd ..; \
	done
	@echo "All stacks valid!"

backup:
	@echo "Backing up Nextcloud DB..."
	@cd nextcloud && docker compose exec -T db pg_dump -U nextcloud nextcloud > nextcloud_db_$$(date +%F).sql && cd .. 2>/dev/null || true
	@echo "Backing up Gitea..."
	@cd gitea && docker compose exec -T gitea gitea dump -c /data/gitea/conf/app.ini 2>/dev/null || true
	@echo "Backing up Vaultwarden..."
	@cd vaultwarden && docker compose exec -T vaultwarden sqlite3 /data/db.sqlite3 ".backup /data/db-backup.sqlite3" 2>/dev/null || true
	@echo "Backup complete."

update:
	@if [ -z "$(STACK)" ]; then echo "Usage: make update STACK=<name>"; exit 1; fi
	@cd $(STACK) && docker compose pull && docker compose up -d