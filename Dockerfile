# Start from the official PHP 8.3 image with FPM (FastCGI Process Manager)
FROM php:8.3-fpm

# Set the working directory in the container
WORKDIR /var/www

# Install system dependencies required for PHP extensions
# We use 'apt-get' for Debian-based images like this one.
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libonig-dev \
    libxml2-dev \
    libzip-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions required by Laravel
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer (PHP package manager)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy existing application directory contents to the container's working directory
COPY . .

# Change the ownership of all files to the 'www-data' user and group.
# This is the user that PHP-FPM runs as, preventing permission issues.
RUN chown -R www-data:www-data /var/www

# Expose port 9000 and start the php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
