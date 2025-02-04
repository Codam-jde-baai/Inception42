DOCKER_COMPOSE := ./srcs/docker-compose.yml
#volume dir for the volumes in the docker-compose
VOLUME_DIR := ${HOME}/inception42_volume/mariadb_data \
				${HOME}/inception42_volume/wordpress_data
# depending on the installation its either docker compose or docker-compose
COMPOSE := docker compose

all: up

build:
	$(COMPOSE) -f $(DOCKER_COMPOSE) build

up:
	@if [ ! -d "$(VOLUME_DIR)" ]; then \
		echo "Creating volume directory $(VOLUME_DIR)"; \
		mkdir -p $(VOLUME_DIR); \
	fi
	$(COMPOSE) -f $(DOCKER_COMPOSE) up -d

down:
	$(COMPOSE) -f $(DOCKER_COMPOSE) down

rebuild: down build up

clean: down
	docker system prune -af
	docker volume prune -af
#docker system prune: 
# `docker system prune -af` removes all unused containers, networks, images (both dangling and unreferenced), and optionally, volumes.
# It helps in reclaiming disk space by cleaning up unused docker artifacts.
# `docker volume prune -af` specifically removes all unused volumes. It helps in freeing up storage space used by volumes not associated with any containers.

status:
	$(COMPOSE) -f $(DOCKER_COMPOSE) ps

logs:
	$(COMPOSE) -f $(DOCKER_COMPOSE) logs

fclean: clean
	sudo rm -rf $(VOLUME_DIR)

re: fclean all

.PHONY: all up down clean fclean re status logs


