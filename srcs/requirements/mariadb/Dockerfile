# **************************************************************************** #
# 
# srcs/requirements/mariadb/Dockerfile
# 
# Author: mlanca-c
# URL: https://github.com/mlanca-c/inception
# Description: dockerfile that will create the image of MariaDB service.
# **************************************************************************** #

# creating a image layer for the OS
FROM debian:10.12

# updating the OS
RUN apt update -y
# RUN apt upgrade -y

# installing mariadb
RUN apt install -y mariadb-server
# installing vim
RUN apt install -y vim

# configuring mariadb
RUN mysql_install_db
RUN service mysql start
RUN service mysql stop

# starting mariadb service
CMD [ "mysqld" ]
