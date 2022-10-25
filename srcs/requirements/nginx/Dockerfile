# **************************************************************************** #
# 
# srcs/requirements/nginx/Dockerfile
# 
# Author: mlanca-c
# URL: https://github.com/mlanca-c/inception
# Description: dockerfile that will create the image of NGINX service.
# **************************************************************************** #

# creating a image layer for the OS
FROM debian:10.12

# updating the OS
RUN apt update -y
# RUN apt upgrade -y

# installing nginx
RUN apt install -y nginx
# installing openssl
RUN apt install -y openssl
# installing vim
RUN apt install -y vim

# creating directory where ssl certs will be stored
RUN mkdir -p /etc/nginx/certs/
RUN chmod 700 /etc/nginx/certs/
# generating certificate and private key
RUN openssl req \
			-nodes \
			-newkey rsa:2048 \
			-x509 \
			-days 365 \
			-out /etc/nginx/certs/selfsigned.crt \
			-keyout /etc/nginx/certs/selfsigned.key \
    		-subj "/C=PT/ST=Lisboa/L=Lisboa/O=42Lisboa/OU=Inception/CN=www.mlanca-c.42.fr"

# configuring nginx
RUN mkdir -p /var/www/wordpress
COPY ./tools/wordpress /etc/nginx/sites-available/default

# starting nginx service
CMD [ "nginx", "-g", "daemon off;" ]
