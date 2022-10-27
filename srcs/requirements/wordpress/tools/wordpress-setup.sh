#!/bin/bash

while ! nc -z "mariadb" "3306"; do
	sleep 1;
done

service php7.3-fpm start;
service php7.3-fpm stop;
php-fpm7.3 -F -R;
