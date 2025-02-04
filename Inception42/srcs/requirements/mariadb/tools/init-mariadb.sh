#!/bin/bash

# Create necessary directories
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# Initialize database if not already done
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysqld --initialize-insecure --user=mysql
fi

# Execute the initialization SQL
exec mysqld_safe --user=mysql --init-file=/tools/init.sql