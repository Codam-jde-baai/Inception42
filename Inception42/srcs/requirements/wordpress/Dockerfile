FROM debian:bookworm

RUN apt-get update -y && \
    apt-get -y install \
    php8.2 \
    php-fpm \
    php-mysql \
    mariadb-client \
    wget \
    curl \
    sendmail \
    apt-get clean

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create directories and set permissions
RUN mkdir -p /run/php8.2 /var/www/html/ /var/log/php8.2-fpm && \
    touch /run/php/php8.2-fpm.pid && \
    chown -R www-data:www-data /var/www/* /var/log/* && \
    chmod -R 755 /var/www/*

# Copy cpmf + install + script
COPY conf/www.conf /etc/php/8.2/fpm/pool.d
COPY tools/setup-wp.sh /tools/setup-wp.sh
#COPY tools/install.php /var/www/html/install.php

# make script executable
RUN chmod +x /tools/setup-wp.sh

# Expose PHP port
EXPOSE 9000

# Entrypoint script
ENTRYPOINT ["/tools/setup-wp.sh"]