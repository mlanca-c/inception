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
RUN apt install -y mariadb-server
# installing vim
RUN apt install -y vim

# adding mariadb server config file
COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/

# copying mariadb-setup.sh to the container
COPY ./tools/mariadb-setup.sh /tmp/

CMD ["/bin/bash", "/tmp/mariadb-setup.sh"]
