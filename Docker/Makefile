help:
	@echo "Makefile for HRI CACTI Docker container"
	@echo "Usage:"
	@echo "make start - start the container"
	@echo "make stop - stop the container"
	@echo "make rm - remove the container image"
	@echo "make shell - open a shell in the container"
	@echo "make build - build the container image"
	@echo "make dir HRI_CACTI_GIT_DIR=<path> - set the HRI_CACTI_GIT_DIR environment variable"
	@echo "make log - show the container logs"

start:
	@xhost +local:docker
	@echo "added docker xhost permissions"
	@export UID_GID=$$(id -u):$$(id -g)
	@export UNAME=$$(whoami)
	@echo "gathering host user info... $$UNAME $$UID_GID"
	@docker compose -f ./docker-compose.yaml up -d

stop:
	@docker compose -f ./docker-compose.yaml down

rm:
	@docker image rm -f hri_cacti_i

shell:
	@docker exec -ti -u $$(whoami) -w ~/ hri_cacti_c bash -l

build:
	@if [ "$$(docker ps -q -f name=hri_cacti_c)" ]; then \
		echo "stopping container hri_cacti_c..."; \
		docker compose -f ./docker-compose.yaml down; \
	fi
	docker compose -f ./docker-compose.yaml build

dir:
	@export HRI_CACTI_GIT_DIR=$(1)

log:
	@docker logs rosd_c
