#!/bin/bash

set -e

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
if [ ! -f /var/www/html/wp-config.php ]; then
    cd /var/www/html
    
    # Downloading WordPress
    wp core download \
        --path="/var/www/html/" \
        --allow-root

    # Create wp-config.php using WP-CLI
    wp config create \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=$MYSQL_HOST \
        --allow-root

    # Create Wordpress Admin
    wp core install \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${MYSQL_ADMIN}" \
        --admin_password="${MYSQL_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_MAIL}" \
        --allow-root

    # Create Wordpress User
    wp user create ${WP_USER} ${WP_USER_EMAIL} \
        --user_pass="${WP_USER_PASSWORD}" \
        --role=editor \
        --allow-root

    # Set WP Home and Site URL
    wp option update home "${WP_URL}" --allow-root
    wp option update siteurl "${WP_URL}" --allow-root

    # Enable/Disable debugging based on environment
    if [ "$WP_DEBUG" = "true" ]; then
        wp config set WP_DEBUG true --allow-root
    else
        wp config set WP_DEBUG false --allow-root
    fi

    echo "WordPress setup complete."
else
    echo "WordPress is already downloaded and setup."
fi

# Start PHP-FPM in the foreground
echo "Successfully reached start point of WordPress"
exec /usr/sbin/php-fpm8.2 -F