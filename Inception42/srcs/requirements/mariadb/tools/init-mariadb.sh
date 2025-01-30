#!/bin/bash

# Start the MariaDB server in the background
mysqld_safe &

# wait for the mariadb server to setup
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Verify the my.cnf file is being used
echo "Verifying my.cnf usage..."
mysqld --verbose --help | grep -A 1 "Default options"
mysqld --print-defaults

# Log the output of the SQL script execution
echo "Executing SQL script..."
mysqld --bootstrap < /docker-entrypoint-initdb.d/users.sql > /tmp/sql_script_output.log 2>&1

if [ $? -ne 0 ]; then
    echo "Failed to execute SQL script. Check /tmp/sql_script_output.log for details."
    echo "Printing error log:"
    cat /tmp/sql_script_output.log
    exit 1
fi

# Shut down the MariaDB server gracefully
mysqladmin shutdown

# Start the MariaDB server in the foreground
exec mysqld