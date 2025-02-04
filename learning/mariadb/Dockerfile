FROM debian:buster

ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ADMIN
ARG MYSQL_ADMIN_PASSWORD

ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
ENV MYSQL_ADMIN=${MYSQL_ADMIN}
ENV MYSQL_ADMIN_PASSWORD=${MYSQL_ADMIN_PASSWORD}

RUN apt-get update -y && apt-get install -y mariadb-server gettext-base

# copy the users.sql and the init-mariadb.sh
COPY ./tools /tools
# give exec rights to the scirpt
RUN chmod +x /tools/init-mariadb.sh
# Prepare the initialization script
RUN cat /tools/users.sql | envsubst > /tools/init.sql


# Modify MariaDB configuration to allow remote connections
RUN sed -i 's/bind-address.*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf



EXPOSE 3306

CMD ["/tools/init-mariadb.sh"]