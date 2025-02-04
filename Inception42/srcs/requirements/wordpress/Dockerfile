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
    && rm -rf /var/lib/apt/lists/*

# Download WordPress CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Create WordPress directory
RUN mkdir -p /var/www/html

#setting the dockerfile's working directory
WORKDIR /var/www/html

RUN mkdir -p /var/log/php-fpm \
	/var/log/php-fpm

# Copy WordPress install.php and the entrypoint script
COPY ./tools/install.php /var/www/html/wp-content/install.php
COPY ./tools/setup-wp.sh /tools/setup-wp.sh
RUN chmod +x /tools/setup-wp.sh

# COPY the config file for custom settings
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# Expose PHP-FPM port
EXPOSE 9000

# Entrypoint script
CMD ["/tools/setup-wp.sh"]