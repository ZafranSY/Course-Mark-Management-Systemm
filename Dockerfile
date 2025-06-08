# Use the official PHP 8.1 Alpine image as a base image
FROM php:8.1-alpine

# Install system dependencies and PHP extensions
RUN apk --no-cache add \
    bash \
    git \
    libpng-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Install Composer (PHP Dependency Manager)
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Set the working directory to /var/www
WORKDIR /var/www

# Copy the composer.json and composer.lock (if available) to the container
COPY composer.json /var/www/

# Install PHP dependencies using Composer
RUN composer install

# Copy the rest of your application code to the container
COPY . /var/www

# Expose the port 8080
EXPOSE 8080

# Set the command to run the PHP built-in server
CMD ["php", "-S", "0.0.0.0:8080", "-t", "public"]
