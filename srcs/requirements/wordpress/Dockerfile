# **************************************************************************** #
# 
# srcs/requirements/wordpress/Dockerfile
# 
# Author: mlanca-c
# URL: https://github.com/mlanca-c/inception
# Description: dockerfile that will create the image of WordPress service.
# **************************************************************************** #

# creating a image layer for the OS
FROM debian:10.12

# updating the OS
RUN apt update -y
# RUN apt upgrade -y

# # installing curl
# RUN apt install -y curl
# installing php and recommended extensions
RUN apt install -y php7.3 \
				   php7.3-fpm
# installing vim
RUN apt install -y vim

# configuring php

# configuring wordpress

# starting php-fpm service
RUN service php7.3-fpm start
RUN service php7.3-fpm stop
CMD [ "php-fpm7.3", "-F", "-R" ]
