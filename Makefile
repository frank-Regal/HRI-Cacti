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
	@xhost +local:docker; \
	export UID_GID=$$(id -u):$$(id -g); \
	export UNAME=$$(whoami); \
	docker compose --profile bridge up

stop:
	@docker compose down

shell:
	@docker exec -ti -u $$(whoami) -w ~/ hri_cacti_c bash -l

build:
	@docker compose --profile bridge build

dir:
	@export HRI_CACTI_GIT_DIR=$(1)

log:
	@docker logs rosd_c
