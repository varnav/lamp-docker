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

Exposed port and volumes
----

The image exposes ports `80` and `3306`, and exports four volumes:

* `/var/log/httpd`, containing Apache log files.
* `/var/log/mysql` containing MariaDB log files.
* `/var/www/html`, used as Apache's [DocumentRoot directory](http://httpd.apache.org/docs/2.4/en/mod/core.html#documentroot).
* `/var/lib/mysql`, where MariaDB data files are stored.
* `/etc/apache2`, where Apache configuration files are stored.

Please, refer to https://docs.docker.com/storage/volumes for more information on using host volumes.

The user and group owner id for the DocumentRoot directory `/var/www/html` are both 33 (`uid=33(www-data) gid=33(www-data) groups=33(www-data)`).

The user and group owner id for the MariaDB directory `/var/log/mysql` are 105 and 108 repectively (`uid=105(mysql) gid=108(mysql) groups=108(mysql)`).

Use cases
----

#### Create a temporary container for testing purposes:

```
	docker run -i -t --rm varnav/lamp bash
```

#### Create a temporary container to debug a web app:

```
	docker run --rm -p 8080:80 -e LOG_STDOUT=true -e LOG_STDERR=true -e LOG_LEVEL=debug -v /my/data/directory:/var/www/html varnav/lamp
```

#### Create a container linking to another [MySQL container](https://registry.hub.docker.com/_/mysql/):

```
	docker run -d --link my-mysql-container:mysql -p 8080:80 -v /my/data/directory:/var/www/html -v /my/logs/directory:/var/log/httpd --name my-lamp-container varnav/lamp
```

#### Get inside a running container and open a MariaDB console:

```
	docker exec -i -t my-lamp-container bash
	mysql -u root
```
