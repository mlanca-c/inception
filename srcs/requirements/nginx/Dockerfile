# **************************************************************************** #
#
# nginx/Dockerfile
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
RUN apt install -y nginx
# installing openssl
RUN apt install -y openssl
# installing vim
RUN apt install -y vim

# create server root dir
RUN mkdir -p /var/www/wordpress

# adding wordpress server config file in sites-available
COPY ./tools/wordpress /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/

# generating self signed certificate and key
RUN openssl req \
	-x509 \
	-nodes \
	-days 365 \
	-newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/C=PT/ST=Lisboa/L=Lisboa/O=42Lisboa/OU=Inception/CN=www.mlanca-c.42.fr"

CMD ["nginx", "-g", "daemon off;"]
