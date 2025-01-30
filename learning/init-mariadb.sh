#!/bin/bash

# Check if there is already a MariaDB database
if [ -d "/var/lib/mysql/mysql" ]; then
    echo "Database already initialized"
    # Start the MariaDB server in the foreground
    exec mysqld --verbose --help
else
    echo "Initializing MariaDB database..."
    # Initialize the database
    mysql_install_db --datadir=/var/lib/mysql

    # Start MariaDB service
    service mysql start

    # Load data from users.sql
    mysql -u root <<EOF
SOURCE /docker-entrypoint-initdb.d/users.sql;
EOF

    # Shutdown the MariaDB service
    service mysql stop

    # Start the MariaDB server in the foreground
    exec mysqld --verbose --help
fi