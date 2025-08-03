# docker-php

A Dockerized PHP development environment with Nginx and MySQL support.

## Features

- PHP 8.3 with FPM
- Customizable PHP settings ([docker/php/custom.ini](docker/php/custom.ini))
- Nginx web server ([docker/nginx/default.conf](docker/nginx/default.conf))
- MySQL database integration (see [../docker-db/docker-compose.yml](../docker-db/docker-compose.yml))
- Composer pre-installed
- Easy local development with hot-reloading via Docker volumes

## Directory Structure

```
docker-php/
  ├── Dockerfile
  ├── docker-compose.yml
  ├── index.php
  ├── docker/
  │   ├── nginx/
  │   │   └── default.conf
  │   └── php/
  │       └── custom.ini
  └── ...
```

## Usage

### 1. Start the Database

First, ensure the external database network exists and start the MySQL service:

```sh
cd ../docker-db
docker network create db-network  # Only needed once
docker-compose up -d
```

### 2. Start PHP & Nginx

From the `docker-php` directory:

```sh
docker-compose up --build -d
```

- PHP-FPM runs in the `app` service.
- Nginx serves your app at [http://localhost:8000](http://localhost:8000).

### 3. Access phpMyAdmin

phpMyAdmin is available at [http://localhost:8081](http://localhost:8081) (from the `docker-db` stack).

## Customization

- **PHP settings:** Edit [`docker/php/custom.ini`](docker/php/custom.ini)
- **Nginx config:** Edit [`docker/nginx/default.conf`](docker/nginx/default.conf)
- **Database config:** Edit [`../docker-db/mysql.cnf`](../docker-db/mysql.cnf)

## Example

The default [`index.php`](index.php) outputs:

```php
echo "Hello, World! This is a PHP script running in a Docker container.\n";
```

## License

MIT © 2025 MD Nazmul Hasan Sheum
