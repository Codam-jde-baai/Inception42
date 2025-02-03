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

## Install MariaDB and required tools
RUN apt-get update && \
	apt-get install -y mariadb-server gettext-base && \
	apt-get clean

# Copy initialization files
COPY ./tools/users.sql /tools/users.sql

# Process SQL file with environment variables
RUN cat /tools/users.sql | envsubst > /tools/users.sql

# give permissions to the script
#RUN chmod +x /tools/init-mariadb.sh

# Copy MySQL configuration
# COPY ./conf/my.cnf /etc/mysql/my.cnf
RUN sed -i 's/bind-address = 127.0.0.1/bind-address = 0.0.0.0/' \
	-i /etc/mysql/mariadb.conf.d/50-server.cnf


# Create necessary directories with correct permissions
# RUN mkdir -p /var/run/mysqld /var/lib/mysql /var/log/mysql && \
# 	chown -R mysql:mysql /var/run/mysqld /var/lib/mysql /var/log/mysql && \
# 	chmod 755 /var/run/mysqld

RUN service mysql start && mysql < /tools/users.sql
# Expose MariaDB port
EXPOSE 3306

CMD ["mysqld"]