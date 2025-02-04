#!/bin/bash

set -e

echo "Attempting to connect to database..."
mysqladmin -h mariadb -u$MYSQL_USER -p$MYSQL_PASSWORD ping

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

# Install WordPress
wp core install \
    --url=$WORDPRESS_URL \
    --title="$WORDPRESS_TITLE" \
    --admin_user=$WORDPRESS_ADMIN_USER \
    --admin_password=$WORDPRESS_ADMIN_PASSWORD \
    --admin_email=$WORDPRESS_ADMIN_EMAIL \
    --allow-root

# Create a second user
wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL \
    --role=editor \
    --user_pass=$WORDPRESS_USER_PASSWORD \
    --allow-root

# Start PHP-FPM
exec php-fpm7.3 -F