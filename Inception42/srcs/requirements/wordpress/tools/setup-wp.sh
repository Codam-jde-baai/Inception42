#!/bin/bash

set -e


echo "MYSQL_DATABASE: $MYSQL_DATABASE"  
echo "MYSQL_USER: $MYSQL_USER"  
echo "MYSQL_PASSWORD: $MYSQL_PASSWORD"  
echo "MYSQL_HOST: $MYSQL_HOST"  
echo "WORDPRESS_URL: $WORDPRESS_URL"  
echo "WORDPRESS_TITLE: $WORDPRESS_TITLE"  
echo "WORDPRESS_ADMIN_USER: $WORDPRESS_ADMIN_USER"  
echo "WORDPRESS_ADMIN_PASSWORD: $WORDPRESS_ADMIN_PASSWORD"  
echo "WORDPRESS_ADMIN_EMAIL: $WORDPRESS_ADMIN_EMAIL"  
echo "WORDPRESS_USER: $WORDPRESS_USER"  
echo "WORDPRESS_USER_PASSWORD: $WORDPRESS_USER_PASSWORD"
echo "WORDPRESS_USER_EMAIL: $WORDPRESS_USER_EMAIL"
echo "WP_DEBUG: $WP_DEBUG"


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

# Navigate to WordPress directory
cd /var/www/html

# Remove existing WordPress files
rm -rf *

# Download WordPress
wp core download --allow-root

# Configure WordPress with force flag
wp config create \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=mariadb \
    --allow-root \
    --force

# Install WordPress with additional error handling
if ! wp core install \
    --url=$WORDPRESS_URL \
    --title="$WORDPRESS_TITLE" \
    --admin_user=$WORDPRESS_ADMIN_USER \
    --admin_password=$WORDPRESS_ADMIN_PASSWORD \
    --admin_email=$WORDPRESS_ADMIN_EMAIL \
    --allow-root \
    --skip-email; then
    echo "WordPress installation failed. Attempting to create tables manually."
    wp db create --allow-root
    wp core create-tables --allow-root
fi

# Create a second user
wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL \
    --role=editor \
    --user_pass=$WORDPRESS_USER_PASSWORD \
    --allow-root

# Start PHP-FPM
exec php-fpm7.3 -F