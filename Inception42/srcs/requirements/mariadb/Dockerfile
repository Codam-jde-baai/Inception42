FROM debian:11

# get the ARGS and set them to env
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

RUN apt-get update && \
	apt-get install -y mariadb-server && \
	apt-get clean && \
	mkdir -p /var/run/mysqld && \
	chown mysql:mysql /var/run/mysqld

#add mariadb
#add mariadb client
#add gettext which is used by mariadb to handle the locale
# added a new directory /var/run/mysqld and change the owner to mysql:mysql

COPY ./tools/ /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init-mariadb.sh
#copy the tools dir to /tools inside the docker container

COPY ./conf/my.cnf /etc/mysql/my.cnf
#copy the my.cnf file to /etc/my.cnf inside the docker container

RUN sed 's/bind-address = 127.0.0.1/bind-address = 0.0.0.0/' \
	-i /etc/mysql/my.cnf
#replace the bind-address in the my.cnf file to 0.0.0.0

EXPOSE 3306

CMD ["mysqld"]

#ENTRYPOINT [ "/docker-entrypoint-initdb.d/init-mariadb.sh" ]