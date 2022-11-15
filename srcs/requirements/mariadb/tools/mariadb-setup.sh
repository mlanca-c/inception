#!/bin/bash

mysql_install_db;
service mysql start;

# Configure database
if [ -f /var/lib/mysql/${DB_NAME} ]
	echo "${DB_NAME} already created"
then
	# creating database
	mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
	# creating user DB_USER %
	mariadb -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
	mariadb -u root -e "GRANT ALL ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
	mariadb -u root -e "FLUSH PRIVILEGES;"
	# creating user DB_USER local
	mariadb -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
	mariadb -u root -e "GRANT ALL ON ${DB_NAME}.* TO '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
	mariadb -u root -e "FLUSH PRIVILEGES;"
	echo "${DB_NAME} created database"
	
	mariadb -u root -e "CREATE TABLE ${DB_NAME}.todo_list (item_id INT AUTO_INCREMENT, content VARCHAR(255), PRIMARY KEY(item_id));"
	mariadb -u root -e "INSERT INTO ${DB_NAME}.todo_list (content) VALUES ('My first task, yay');"
	mariadb -u root -e "INSERT INTO ${DB_NAME}.todo_list (content) VALUES ('Second task, gimme more');"
	mariadb -u root -e "INSERT INTO ${DB_NAME}.todo_list (content) VALUES ('Last task i promise');"
	mariadb -u root -e "INSERT INTO ${DB_NAME}.todo_list (content) VALUES ('one more task');"
fi

service mysql stop;
mysqld;
