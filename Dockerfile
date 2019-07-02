FROM ubuntu:18.04

LABEL Maintainer = "Evgeny Varnavskiy <varnavruz@gmail.com>" \
      Description="PHP 7.2 with basic modules + Apache 2.4 + MariaDB + Certbot" \
	  License="Apache License 2.0"

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=dumb
COPY debconf.selections /tmp/
RUN apt-get update && apt-get install -y software-properties-common \
&& add-apt-repository -y ppa:certbot/certbot && apt-get update \
&& debconf-set-selections /tmp/debconf.selections \
&& apt-get install --no-install-recommends -y zip unzip \
	php7.2 \
	php7.2-bz2 \
	php7.2-cgi \
	php7.2-cli \
	php7.2-common \
	php7.2-curl \
	php7.2-fpm \
	php7.2-gd \
	php7.2-intl \
	php7.2-json \
	php7.2-mbstring \
	php7.2-mysql \
	php7.2-odbc \
	php7.2-xmlrpc \
	php7.2-zip \
	apache2 \
	mariadb-common mariadb-server mariadb-client \
	postfix \
	git nodejs npm composer nano mc curl ftp \
	python-certbot-apache \
&& rm -rf /var/lib/apt/lists/*

COPY index.php /var/www/html/
COPY run-lamp.sh /usr/sbin/

RUN a2enmod proxy_fcgi setenvif rewrite && a2enconf php7.2-fpm && chmod +x /usr/sbin/run-lamp.sh

VOLUME /var/www/html
VOLUME /var/log/httpd
VOLUME /var/lib/mysql
VOLUME /var/log/mysql
VOLUME /etc/apache2
VOLUME /etc/letsencrypt

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/run-lamp.sh"]
