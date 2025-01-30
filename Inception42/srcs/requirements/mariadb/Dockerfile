FROM debian:buster

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
	apt-get install -y mariadb-server gettext-base && \
	apt-get clean


#add mariadb
#add mariadb client
#add gettext which is used by mariadb to handle the locale

COPY ./tools/ /docker-entrypoint-initdb.d/
RUN cat /docker-entrypoint-initdb.d/users.sql | envsubst > /docker-entrypoint-initdb.d/users.sql
#copy the tools dir to /tools inside the docker container

COPY ./conf/my.cnf /root/.my.cnf
RUN sed 's/bind-address = 127.0.0.1/bind-address = 0.0.0.0/' \
	-i /root/.my.cnf
#replace the bind-address in the my.cnf file to 0.0.0.0
RUN chmod 644 /root/.my.cnf

#creating files set in the my.cnf
RUN mkdir -p /var/run/mysqld && \
	chown mysql:mysql /var/run/mysqld && \
	mkdir -p /var/lib/mysql && \
	chown mysql:mysql /var/lib/mysql && \
	mkdir -p /var/log/mysql && \
	chown mysql:mysql /var/log/mysql


RUN service mysql start && mysql < /docker-entrypoint-initdb.d/users.sql

EXPOSE 3306

CMD ["mysqld"]
#ENTRYPOINT [ "/docker-entrypoint-initdb.d/init-mariadb.sh" ]