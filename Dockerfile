FROM ubuntu:20.04

RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN apt update -y
RUN apt install -y software-properties-common curl iputils-ping mysql-client iproute2 vim
RUN add-apt-repository ppa:ondrej/php
RUN apt install -y php7.2 php7.2-mysql php7.2-mbstring php7.2-curl

# https://wp-cli.org/
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

ARG WP_FILE
ADD wordpress-files/${WP_FILE} /var/www/html
ADD docker/apache2.conf .
RUN mv apache2.conf /etc/apache2/
ADD docker/.htaccess /var/www/html
RUN chmod 777 /var/www/html/.htaccess

RUN rm /var/www/html/index.html
RUN a2enmod rewrite

WORKDIR /var/www/html

RUN wp --allow-root config create \
   --dbhost=wp-db \
   --dbname=wordpress \
   --dbuser=wordpress_db_user \
   --dbpass=wordpress_db_password \
   --locale=ja_JP \
   --skip-check

CMD /usr/sbin/apache2ctl -DFOREGROUND