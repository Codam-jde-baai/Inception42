FROM debian:buster

# Install required dependencies
RUN apt-get update && apt-get install -y \
    php7.3 \
    php7.3-fpm \
    php7.3-mysql \
    php7.3-curl \
    php7.3-gd \
    php7.3-mbstring \
    php7.3-xml \
    php7.3-zip \
    wget \
    mariadb-client \
    && apt-get clean

# Download WordPress CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Create WordPress directory and log directories
RUN mkdir -p /var/www/html /var/log/php-fpm

# Set working directory
WORKDIR /var/www/html

# Copy configuration and scripts
COPY ./tools/setup-wp.sh /tools/setup-wp.sh
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# Ensure script is executable
RUN chmod +x /tools/setup-wp.sh

# Ensure log directory permissions
RUN chown -R www-data:www-data /var/www/html /var/log/php-fpm

# Expose PHP-FPM port
EXPOSE 9000

# Entrypoint script
ENTRYPOINT ["/tools/setup-wp.sh"]