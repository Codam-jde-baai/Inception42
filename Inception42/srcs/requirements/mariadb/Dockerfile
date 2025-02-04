FROM debian:bookworm

RUN apt-get update -y \ 
	&& apt-get install -y mariadb-server gettext-base \
	&& apt-get clean

# copy the users.sql and the init-mariadb.sh
COPY ./tools /tools
# give exec rights to the scirpt
RUN chmod +x /tools/init-mariadb.sh


# # Modify MariaDB configuration to allow remote connections
# add the custom config to the directory last read by msql, making it the leading settings
COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/custom.cnf


EXPOSE 3306

CMD ["/tools/init-mariadb.sh"]