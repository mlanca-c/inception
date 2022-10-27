# **************************************************************************** #
#
# wordpress/Dockerfile
#
# user: mlanca-c
# URL: https://github.com/mlanca-c/inception
# description: this file composes the docker image of nginx
# **************************************************************************** #

# creating a base OS image
FROM debian:10.12

# updating OS
RUN apt update -y

# installing wordpress
# https://make.wordpress.org/hosting/handbook/server-environment/#system-packages
RUN apt install -y php7.3 \
                   php7.3-fpm \
                   php7.3-mysql \
                   php7.3-json \
                   php7.3-common \
                   php7.3-mbstring \
                   php7.3-curl \
                   php7.3-dom \
                   php7.3-exif \
                   php7.3-fileinfo \
                   php7.3-imagick \
				   php7.3-cli \
                   php7.3-xml \
                   php7.3-zip
# installing netcat
RUN apt install -y netcat
# installing vim
RUN apt install -y vim
# installing curl
RUN apt install -y curl

# setting the right conf file for php
COPY ./tools/www.conf /etc/php/7.3/fpm/pool.d/

RUN mkdir -p /var/www/wordpress
WORKDIR /var/www/wordpress

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

RUN wp core download --allow-root

# create server root dir
# COPY ./tools/todo_list.php /var/www/wordpress/
COPY ./tools/todo_list.php /tmp/

# copying wordpress-setup.sh to the container
COPY ./tools/wordpress-setup.sh /tmp/
# starting php-fpm service
CMD ["/bin/bash", "/tmp/wordpress-setup.sh"]
