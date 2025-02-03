DOCKER_COMPOSE = ./docker-compose.yml
VOLUME_DIR = ${HOME}/inception42_volume/mariadb_data

all: up

build:
	docker-compose -f $(DOCKER_COMPOSE) build

up:
	@if [ ! -d "$(VOLUME_DIR)" ]; then \
		echo "Creating volume directory $(VOLUME_DIR)"; \
		mkdir -p $(VOLUME_DIR); \
	fi
	docker-compose -f $(DOCKER_COMPOSE) up -d

down:
	docker-compose -f $(DOCKER_COMPOSE) down

rebuild: down build up

clean: down
	docker system prune -af
	docker volume prune -af
#docker system prune: 
# `docker system prune -af` removes all unused containers, networks, images (both dangling and unreferenced), and optionally, volumes.
# It helps in reclaiming disk space by cleaning up unused docker artifacts.
# `docker volume prune -af` specifically removes all unused volumes. It helps in freeing up storage space used by volumes not associated with any containers.

status:
	docker-compose -f $(DOCKER_COMPOSE) ps

logs:
	docker-compose -f $(DOCKER_COMPOSE) logs

fclean: clean

re: fclean all

.PHONY: all up down clean fclean re status logs


