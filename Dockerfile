FROM php:7.4-fpm

# vars
ENV USERNAME laravel
ENV ENVIRONMENT live
ENV PROJECT_NAME generic-api

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        nginx \
        vim \
        zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && \
    # Install PHP extensions
    docker-php-ext-install pdo_mysql && \
    # creating one single dir for all sources
    mkdir ${PROJECT_NAME}

# Setting up nginx
COPY resources/nginx/default /etc/nginx/sites-available/default

# Get the code
ADD . ${PROJECT_NAME}/.

## Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# INSTALL
    # Adding an user to run the code
RUN groupadd ${USERNAME} && \
    useradd -d /home/${USERNAME} -ms /bin/bash -g ${USERNAME} -G sudo ${USERNAME} && \
    usermod -a -G www-data ${USERNAME} && \
    # setting up the groups
    chown -R www-data:www-data ${PROJECT_NAME} && \
    chmod -R 777 ${PROJECT_NAME}
USER ${USERNAME}

RUN cd ${PROJECT_NAME} && \
    cp .env.example .env && \
    composer install -q --no-ansi --no-interaction --no-scripts --no-suggest --no-progress --prefer-dist --no-dev

USER root

RUN nginx
