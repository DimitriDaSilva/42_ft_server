# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start_container.sh                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dda-silv <dda-silv@student.42lisboa.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/12 20:45:39 by dda-silv          #+#    #+#              #
#    Updated: 2021/03/12 22:17:38 by dda-silv         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# Nginx setup

## Following the Nginx installation guide specific for Debian / Ubuntu repo
## https://www.linode.com/docs/guides/how-to-configure-nginx/

## Folder where nginx will go fetch data to serve. Path specified in nginx.conf
mkdir /var/www/localhost

## Give the ownership of the directory to www-data (user used by nginx)
chown -R www-data /var/www/localhost

## Copying the nginx.conf file. It has to be named after the name of the site
cp nginx.conf /etc/nginx/sites-available/localhost

## Linking conf files between both folders
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

## Removing the template nginx.conf (not required but cleaner)
rm -rf /etc/nginx/sites-enabled/default

# SSL setup

## Following this guide: https://linuxize.com/post/creating-a-self-signed-ssl-certificate/
## Used openssl and doesn't require prompt input (cf. -subj flag)

mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 \
			-x509 \
			-sha256 \
			-days 3650 \
			-nodes \
			-out /etc/nginx/ssl/localhost.crt \
			-keyout /etc/nginx/ssl/localhost.key \
			-subj "/C=PT/ST=Lisbon/L=Lisbon/O=42Lisboa/OU=dda-silv/CN=www.localhost.com"

# MySQL setup

## Following this guide https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mariadb-php-lemp-stack-on-debian-10

service mysql start

echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'wordpress'@'localhost';" | mysql -u root
echo "SET password FOR 'wordpress'@'localhost' = password('password');" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY 'password';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

# PhpMyAdmin setup

mkdir /var/www/localhost/phpMyAdmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.tar.gz
tar -xvf phpMyAdmin-5.1.0-all-languages.tar.gz --


service nginx start