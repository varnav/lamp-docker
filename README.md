varnav/lamp
==========

[![Docker Pulls](https://img.shields.io/docker/pulls/varnav/lamp.svg?style=plastic)](https://hub.docker.com/r/varnav/lamp/)
[![Docker Build Status](https://img.shields.io/docker/build/varnav/lamp.svg?style=plastic)](https://hub.docker.com/r/varnav/lamp/builds/)
[![](https://images.microbadger.com/badges/image/varnav/lamp.svg)](https://microbadger.com/images/varnav/lamp "varnav/lamp")

This Docker container implements a last generation LAMP stack with a set of popular PHP modules. Postfix service to allow sending emails through PHP [mail()](http://php.net/manual/en/function.mail.php) function.

## What's special

Based on [fauria/lamp](https://github.com/fauria/docker-lamp)

* Ubuntu updated to 18.04
* PHP updated to 7.2
* Thrown away most unneeded modules, nmp & stuff
* Added support for Certbot (Let's encrypt)

## Exposed port and volumes

The image exposes ports `80` and `3306`, and exports four volumes:

* `/var/log/httpd`, containing Apache log files.
* `/var/log/mysql` containing MariaDB log files.
* `/var/www/html`, used as Apache's [DocumentRoot directory](http://httpd.apache.org/docs/2.4/en/mod/core.html#documentroot).
* `/var/lib/mysql`, where MariaDB data files are stored.
* `/etc/apache2`, where Apache configuration files are stored.
* `/etc/letsencrypt` for Certbot's files and keys

Please, refer to https://docs.docker.com/storage/volumes for more information on using host volumes.

The user and group owner id for the DocumentRoot directory `/var/www/html` are both 33 (`uid=33(www-data) gid=33(www-data) groups=33(www-data)`).

The user and group owner id for the MariaDB directory `/var/log/mysql` are 105 and 108 repectively (`uid=105(mysql) gid=108(mysql) groups=108(mysql)`).

## Usage

```
docker run -d -p 80:80 -p 443:443 --name lamp-1 -v /opt/example.com/html:/var/www/html -v /opt/example.com/letsencrypt:/etc/letsencrypt -v example.com-database:/var/lib/mysql varnav/lamp
```

Copy your files to `/opt/example.com/html`

Get HTTPS cert:

```
docker exec -i -t lamp-1 bash
certbot --apache -d beta.coinfia.com
```

## Get inside a running container and open a MariaDB console:

```
docker exec -i -t lamp-1 bash
mysql -u root
```
