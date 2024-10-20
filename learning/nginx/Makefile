DOCKER_COMPOSE = ./srcs/docker-compose.yml

all: up

debian:
	docker pull image debian

up:
	docker-compose -f $(DOCKER_COMPOSE) up -d

down:
	docker-compose -f $(DOCKER_COMPOSE) down

testclean: down
	docker container prune -f
	docker network prune -f
	docker volume prune -f
	docker image prune -af --filter "label!=debian:11"

clean: down
	docker container prune -f
	docker network prune -f
#docker system prune: 
# `docker system prune -af` removes all unused containers, networks, images (both dangling and unreferenced), and optionally, volumes.
# It helps in reclaiming disk space by cleaning up unused docker artifacts.
# `docker volume prune -af` specifically removes all unused volumes. It helps in freeing up storage space used by volumes not associated with any containers.

status:
	docker-compose -f $(DOCKER_COMPOSE) ps

fclean: clean
	docker system prune -af
	docker volume prune -af

re: fclean all

.PHONY: all up down clean fclean re status debian testclean


