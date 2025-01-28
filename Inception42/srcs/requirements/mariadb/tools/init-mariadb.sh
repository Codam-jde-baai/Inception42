#!/bin/bash

# Start MariaDB server in the background
mysqld_safe --skip-networking &

# Wait for the server to be ready
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# Execute the SQL script
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" < /docker-entrypoint-initdb.d/init-mariadb.sh

# Shutdown the MariaDB server
mysqladmin shutdown

# Start MariaDB server in the foreground
exec mysqld