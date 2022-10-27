#!/bin/bash

while ! nc -z "mariadb" "3306"; do
	sleep 1;
done

# wp-config.php file
wp config create \
		--dbname=${DB_NAME} \
		--dbuser=${DB_USER} \
		--dbpass=${DB_PASSWORD} \
		--dbhost=${DB_HOST} \
		--allow-root

# create administrator
chmod 644 wp-config.php
wp core install \
	--url=${WP_URL} \
	--title=${WP_TITLE} \
	--admin_name=${WP_ADMIN} \
	--admin_password=${WP_ADMIN_PASS} \
	--admin_email=${WP_ADMIN_MAIL} \
	--allow-root

# Create user
wp user create ${WP_USER} ${WP_USER_MAIL} \
	--user_pass=${WP_USER_PASS} \
	--role=editor \
	--allow-root

service php7.3-fpm start;
service php7.3-fpm stop;
php-fpm7.3 -F -R;
