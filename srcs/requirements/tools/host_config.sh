#!/bin/bash

# Sourcing .env file.
if [ ! -f srcs/.env ]
then
	echo "[error]: unable to source srcs/.env file"
	exit 1
fi
source srcs/.env

if [ -z ${1} ]
then
	echo "[error]: script needs arguments"
	exit 1
fi

if [ ${1} == "check" ]
then
	(grep -q -F "mlanca-c.42.fr" /etc/hosts && exit 0) || exit 1
fi

# Modifying /etc/hosts. Adding domain names for nginx-prod container IP
if [ ${1} == "up" ]
then

	# Getting nginx-prod container IP address
	NGINX_DOCKER_IP=`docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx`
	if [ -z ${NGINX_DOCKER_IP} ]
	then
		echo "[error]: failed to get nginx container IP address"
		exit 1
	fi

	sudo sed -i "/^# Nginx/d" /etc/hosts
	sudo sed -i "/42.fr/d" /etc/hosts

	sudo echo "# Nginx Container Port" >> /etc/hosts
	sudo echo "${NGINX_DOCKER_IP} mlanca-c.42.fr" >> /etc/hosts
	sudo echo "${NGINX_DOCKER_IP} www.mlanca-c.42.fr" >> /etc/hosts
	sudo echo "${NGINX_DOCKER_IP} https://www.mlanca-c.42.fr" >> /etc/hosts
	sudo echo "${NGINX_DOCKER_IP} https://mlanca-c.42.fr" >> /etc/hosts
fi

# Undoing modifications in add
if [ ${1} == "down" ]
then
	sudo sed -i "/^# Nginx/d" /etc/hosts
	sudo sed -i "/42.fr/d" /etc/hosts
fi
