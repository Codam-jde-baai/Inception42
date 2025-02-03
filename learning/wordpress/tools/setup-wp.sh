#!/bin/bash

# Navigate to WordPress directory
cd /var/www/html

# If WordPress is not installed, download and configure
if [ ! -f "wp-config.php" ]; then
    # Download WordPress
    wp core download --allow-root

    # Configure WordPress
    wp config create \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=$WORDPRESS_DB_HOST \
        --allow-root

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
fi

# Start PHP-FPM
exec php-fpm7.3 -F