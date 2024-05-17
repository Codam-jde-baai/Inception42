DOCKER_COMPOSE = srcs/docker-compose.yml

all: up

up:
	docker-compose -f $(DOCKER_COMPOSE) up -d

down:
	docker-compose -f $(DOCKER_COMPOSE) down

clean: down
	docker system prune -af
	docker volume prune -af
#docker system prune: 
# `docker system prune -af` removes all unused containers, networks, images (both dangling and unreferenced), and optionally, volumes.
# It helps in reclaiming disk space by cleaning up unused docker artifacts.
# `docker volume prune -af` specifically removes all unused volumes. It helps in freeing up storage space used by volumes not associated with any containers.

status:
	docker-compose -f $(DOCKER_COMPOSE) ps

fclean: clean

re: fclean all

.PHONY: all up down clean fclean re status


