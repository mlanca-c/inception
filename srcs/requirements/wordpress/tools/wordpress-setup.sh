#!/bin/bash

sleep 10;
# while ! nc -z "mariadb" "3306"; do
# 	sleep 1;
# done

# if [ -f "/var/www/wordpress/wp-config.php" ]; then
# 	echo "${WP_URL} already created"
# else
	cp -f /tmp/wp-config.php /var/www/wordpress/
	chmod 644 /var/www/wordpress/wp-config.php;
	# create administrator
	wp core install --url="mlanca-c.42.fr" --title="inception" --admin_name="mlancac" --admin_email="mlanca-c@42lisboa.com" --admin_password="1234" --allow-root
	# Create user
	wp user create "maria" "maria@student.42lisboa.com" --user_pass="1234" --allow-root
# fi

service php7.3-fpm start;
service php7.3-fpm stop;

php-fpm7.3 -F -R;
