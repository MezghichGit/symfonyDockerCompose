# Pull php-apache image 
FROM php:7.4-apache

# use root user
USER root 

# Install the dependecies to run php
RUN apt-get update && apt-get install -y zlib1g-dev g++ git libicu-dev zip libzip-dev zip \
    && docker-php-ext-install intl opcache pdo pdo_mysql \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip

# Download php composer
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Download Symfony-cli 
# RUN curl -sS https://get.symfony.com/cli/installer | bash   

# Set working directory to the apache public directory 
WORKDIR /var/www/

# Copy all files into the apache public directory
COPY . .

# Copy the apache configuration file into apache container
COPY ./docker/apache.conf  /etc/apache2/sites-available/000-default.conf


# Install the dependecies to run app
# RUN cd /var/www && composer install

# run the script docker.sh
ENTRYPOINT ["bash", "./docker/docker.sh"]

EXPOSE 80
