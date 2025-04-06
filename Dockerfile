FROM php:8.2
RUN apt-get update -y && apt-get install -y \
    openssl zip unzip git libonig-dev libzip-dev libpng-dev libjpeg-dev libpq-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install pdo mbstring

WORKDIR /app
COPY . /app

RUN rm -rf bootstrap/cache/*.php

RUN mkdir -p bootstrap/cache

RUN composer install --no-dev --optimize-autoloader 

RUN php artisan config:clear && \
    chmod -R 775 bootstrap/cache && \
    php artisan config:cache && \
    php artisan cache:clear && \
    php artisan view:clear && \
    php artisan route:clear

RUN php artisan package:discover --ansi

EXPOSE 8181

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8181"]
