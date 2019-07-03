varnav/lamp
==========

[![Docker Pulls](https://img.shields.io/docker/pulls/varnav/lamp.svg?style=plastic)](https://hub.docker.com/r/varnav/lamp/)
[![Docker Build Status](https://api.travis-ci.com/varnav/lamp-docker.svg?branch=master)](https://travis-ci.com/varnav/lamp-docker#)
[![](https://images.microbadger.com/badges/image/varnav/lamp.svg)](https://microbadger.com/images/varnav/lamp "varnav/lamp")

This Docker container implements a last generation LAMP stack with a set of popular PHP modules. Postfix service to allow sending emails through PHP [mail()](http://php.net/manual/en/function.mail.php) function.

## What's special

Based on [fauria/lamp](https://github.com/fauria/docker-lamp)

* Ubuntu updated to 18.04
* PHP updated to 7.2
* Thrown away most unneeded modules, nmp & stuff
* Added support for Certbot (Let's encrypt)

## Exposed port and volumes

The image exposes ports `80` and `443`, and exports volumes:

* `/var/www/html`, used as Apache's [DocumentRoot directory](http://httpd.apache.org/docs/2.4/en/mod/core.html#documentroot).
* `/var/lib/mysql`, where MariaDB data files are stored.
* `/etc/apache2`, where Apache configuration files are stored.
* `/etc/letsencrypt` for Certbot's files and keys

Please, refer to https://docs.docker.com/storage/volumes for more information on using host volumes.

## Usage

```
docker run -d -p 80:80 -p 443:443 --name lamp-1 -v /opt/example.com/html:/var/www/html -v /opt/example.com/letsencrypt:/etc/letsencrypt -v example.com-database:/var/lib/mysql varnav/lamp
```

Copy your files to `/opt/example.com/html`

Get HTTPS cert:

```
docker exec -i -t lamp-1 bash
certbot --apache -d example.com
```

## Get inside a running container and open a MariaDB console:

```
docker exec -i -t lamp-1 bash
mysql -u root
```
