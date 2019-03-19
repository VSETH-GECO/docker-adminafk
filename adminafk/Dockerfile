FROM php:5.6.25-apache

ENV TIMEZONE="Europe/Paris"

RUN a2enmod rewrite && \
    docker-php-ext-install pdo_mysql && \
    echo 'date.timezone = "${TIMEZONE}"' >> /usr/local/etc/php/conf.d/php.ini && \
    apt-get update && apt-get -y install zip netcat mysql-client && \
    apt-get clean && \
    rm -rf /var/www/html/* && \
    curl -L https://github.com/lyon-esport/AdminAFK/archive/master.zip >> /tmp/master.zip && \
    unzip -d /var/www/html /tmp/master.zip && \
    rm -rf /tmp/* && \
    mv /var/www/html/AdminAFK-master/* /var/www/html/ &&\
    rm -rf /var/www/html/AdminAFK-master && \
    chown www-data:www-data -R /var/www

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

COPY entrypoint.sh /sbin/entrypoint.sh

Run chmod +x /sbin/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/sbin/entrypoint.sh"]
