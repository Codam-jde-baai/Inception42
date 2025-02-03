#!/bin/bash

set -e

# Print environment variables for debugging
echo "Initializing MariaDB with the following configuration:"
echo "Database: ${MYSQL_DATABASE}"
echo "User: ${MYSQL_USER}"
echo "Admin User: ${MYSQL_ADMIN}"

# Check if MySQL data directory is empty
if [ ! "$(ls -A /var/lib/mysql)" ]; then
    echo "Initializing MySQL data directory..."
    
    # Initialize the database
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MySQL in the background
mysqld_safe --user=mysql --datadir=/var/lib/mysql &

# Wait for MySQL to start
until mysqladmin ping &>/dev/null; do
    echo "Waiting for database connection..."
    sleep 2
done

# Setup users and databases
mysql < /docker-entrypoint-initdb.d/users.sql

# Shutdown the temporary instance
mysqladmin shutdown

# Start MySQL in the foreground
echo "Starting MariaDB..."
exec mysqld_safe --user=mysql --datadir=/var/lib/mysql