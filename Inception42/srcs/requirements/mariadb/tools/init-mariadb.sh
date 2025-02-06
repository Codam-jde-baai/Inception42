#!/bin/bash

envsubst < /tools/users.sql > /tools/parsed_users.sql

# Create necessary directories
mkdir -p /run/mysqld
mkdir -p /var/lib/mysql
mkdir -p /var/log/mysql/
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /var/run/mysqld
chown -R mysql:mysql /var/log/mysql/

# Initialize database if not already done
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysqld --initialize-insecure --user=mysql
fi

# Execute the initialization SQL
exec mysqld --user=mysql --init-file=/tools/parsed_users.sql