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

# installing nginx
RUN apt install -y php7.3 \
				   php7.3-fpm

# installing vim
RUN apt install -y vim
