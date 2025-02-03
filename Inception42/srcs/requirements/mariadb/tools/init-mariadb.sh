#!/bin/bash


# Start MySQL in the background
service mysql start 
# Run the user SQL script
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" < /tools/users.sql

# Shutdown MySQL server
mysqladmin shutdown

# Run the server again (or exit, depending on your setup)
exec mysqld