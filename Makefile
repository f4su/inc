NAME=		Inception

VOLUMES=	$(shell docker volume ls -q)

.SILENT:

all:
	sudo docker-compose -f ./srcs/docker-compose.yml up --build -d

c:
	sudo docker-compose -f ./srcs/docker-compose.yml down \
		&& sudo docker volume rm srcs_wp_v srcs_mdb_v

s:
	sudo docker ps && sudo docker ps -a && sudo docker volume ls

ng:
	sudo vim -p srcs/requirements/nginx/Dockerfile \
	srcs/requirements/nginx/conf/nginx.conf 

mdb:
	sudo vim -p srcs/requirements/mariadb/Dockerfile \
	srcs/requirements/mariadb/tools/start.sh \
	srcs/requirements/mariadb/tools/setup.sh

wp:
	sudo vim -p srcs/requirements/wordpress/Dockerfile \
	srcs/requirements/wordpress/tools/setup.sh \
	srcs/requirements/wordpress/tools/www.conf
dc:
	sudo vim srcs/docker-compose.yml

e:
	sudo vim srcs/.env

f:
	sudo docker system prune -a

rd:
	sudo rm -rfv ../jgainza/data/db/* ../jgainza/data/wp/*

emdb:
	sudo docker exec -it mariadb sh

re: c all

.PHONY: all c s ng mdb wp dc e rd f 
