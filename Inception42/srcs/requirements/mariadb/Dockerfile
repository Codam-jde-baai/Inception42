FROM alpine:3.19

ARG DOMAIN_NAME
#get the ARG:  DOMAIN_NAME from docker-compose

RUN apk update && apk add mariadb mariadb-client gettext
#add mariadb
#add mariadb client
#add gettext which is used by mariadb to handle the locale


CMD ["mariadb"]

