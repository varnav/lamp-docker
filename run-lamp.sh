#!/bin/bash

DATE_TIMEZONE=UTC

# Set PHP timezone
/bin/sed -i "s/\;date\.timezone\ \=/date\.timezone\ \=\ ${DATE_TIMEZONE}/" /etc/php.ini

# Enable certbot auto-renewal
echo 'certbot renew' > /etc/cron.daily/cert_renew

# Run Postfix
/usr/sbin/postfix start

# Run MariaDB
/usr/bin/mysqld_safe --timezone=${DATE_TIMEZONE}&

/usr/sbin/apachectl -DFOREGROUND -k start
