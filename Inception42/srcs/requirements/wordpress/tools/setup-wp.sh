#!/bin/bash

set -e


echo "MYSQL_HOST: $MYSQL_HOST"
echo "MYSQL_DATABASE: $MYSQL_DATABASE"
echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD"
echo "MYSQL_ADMIN: $MYSQL_ADMIN"
echo "MYSQL_ADMIN_PASSWORD: $MYSQL_ADMIN_PASSWORD"
echo "MYSQL_USER: $MYSQL_USER"
echo "MYSQL_PASSWORD: $MYSQL_PASSWORD"
echo "WP_URL: $WP_URL"
echo "WP_TITLE: $WP_TITLE"
echo "WP_ADMIN_PW: $WP_ADMIN_PW"
echo "WP_USER: $WP_USER"
echo "WP_USER_PASSWORD: $WP_USER_PASSWORD"
echo "WP_USER_EMAIL: $WP_USER_EMAIL"


# Maximum number of connection attempts
MAX_ATTEMPTS=30
ATTEMPT=0

# Wait for MariaDB to be ready
while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
    mysqladmin -h mariadb -u$MYSQL_USER -p$MYSQL_PASSWORD ping > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Database is ready!"
        break
    fi
    
    echo "Waiting for database... (Attempt $((ATTEMPT+1))/$MAX_ATTEMPTS)"
    sleep 2
    ATTEMPT=$((ATTEMPT+1))
done

if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
    echo "Could not connect to database after $MAX_ATTEMPTS attempts"
    exit 1
fi

# Check if WordPress is already installed
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
    cd /var/www/html/wordpress
    
    # Downloading WordPress
    wp core download \
        --path="/var/www/html/wordpress/" \
        --allow-root
    echo "WordPress downloaded."

    # Create wp-config.php using install.php
    echo "Creating WordPress Configuration..."
    php /var/www/html/wordpress/install.php

    # Create Wordpress Admin
    echo "Creating Wordpress Admin..."
    wp core install \
        --path="/var/www/html/wordpress/" \
        --url="${WP_URL}" \
        --title="inception" \
        --admin_user="${MYSQL_ADMIN}" \
        --admin_password="${MYSQL_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_PW}" \
        --allow-root

    # Create Wordpress User
    echo "Creating Wordpress User..." 
    wp user create ${WP_USER} ${WP_USER_EMAIL} \
        --path="/var/www/html/wordpress/" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role=editor \
        --allow-root

    echo "WordPress setup complete."
else
    echo "WordPress is already downloaded and setup."
fi

# Start PHP-FPM in the foreground
echo "Succesfully reached start point of WordPress"
exec /usr/sbin/php-fpm8.2 -F