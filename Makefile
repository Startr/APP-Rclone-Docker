ifneq ($(shell which docker-compose 2>/dev/null),)
    DOCKER_COMPOSE := docker-compose
else
    DOCKER_COMPOSE := docker compose
endif

SHELL := /bin/bash

help: 
	@echo "================================================"
	@echo "  Startr Rclone by Startr.Cloud of Startr LLC   "
	@echo "================================================"
	@echo ""
	@echo 'This is the default make command.' 
	@echo "This command lists available make commands."
	@echo ""
	@echo "Usage example:"
	@echo "    make it_run"
	@echo ""
	@echo "Available make commands:"
	@echo ""
	@LC_ALL=C $(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
		| awk -v RS= -F: '/(^|\n)# Files(\n|$$)/,/(^|\n)# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | grep -E -v -e '^[^[:alnum:]]' -e '^$$@$$'
	@echo ""	
# Configuration variables

it_stop:
	docker rm -f $(CONTAINER_NAME)

it_clean:
	docker system prune -f
	docker builder prune --force

it_run:
	@make it_startr

it_startr:
	@bash <(curl -sL startr.sh) run

it_deploy:
	@caprover deploy --default