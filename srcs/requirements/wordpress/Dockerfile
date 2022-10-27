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
                   php7.3-mysql
# installing vim
RUN apt install -y vim

# setting the right conf file for php
COPY ./tools/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# create server root dir
RUN mkdir -p /var/www/wordpress
COPY ./tools/info.php /var/www/wordpress/

# starting php-fpm service
RUN service php7.3-fpm start
RUN service php7.3-fpm stop
CMD ["php-fpm7.3", "-F", "-R"]
