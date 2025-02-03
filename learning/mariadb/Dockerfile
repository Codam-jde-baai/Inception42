FROM debian:buster

## Get the ARGS and set them to ENV
ARG MYSQL_ROOT_PASSWORD
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}

ARG MYSQL_DATABASE
ENV MYSQL_DATABASE=${MYSQL_DATABASE}

ARG MYSQL_USER
ENV MYSQL_USER=${MYSQL_USER}

ARG MYSQL_PASSWORD
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}

ARG MYSQL_ADMIN
ENV MYSQL_ADMIN=${MYSQL_ADMIN}

ARG MYSQL_ADMIN_PASSWORD
ENV MYSQL_ADMIN_PASSWORD=${MYSQL_ADMIN_PASSWORD}

RUN apt-get update -y && apt-get install -y mariadb-server gettext-base

COPY ./tools /tools

RUN sed 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/' \
	-i /etc/mysql/mariadb.conf.d/50-server.cnf

RUN cat /tools/users.sql | envsubst > /tools/users.sql

RUN service mysql start && mysql < /tools/users.sql

EXPOSE 3306

CMD ["mysqld"]