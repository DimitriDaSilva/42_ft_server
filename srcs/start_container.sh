# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start_container.sh                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dda-silv <dda-silv@student.42lisboa.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/12 20:45:39 by dda-silv          #+#    #+#              #
#    Updated: 2021/03/13 19:27:20 by dda-silv         ###   ########.fr        #
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
mv nginx.conf /etc/nginx/sites-available/localhost

## Linking conf files between both folders
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

## Removing the template nginx.conf (not required but cleaner)
rm -rf /etc/nginx/sites-enabled/default
rm -rf /etc/nginx/sites-available/default

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

mkdir /var/www/localhost/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.tar.gz

## --strip-components=1 is for removing one level of the file tree structure /a/b/c/files -> /b/c/files
## -C <destination>
tar -zxf phpMyAdmin-5.1.0-all-languages.tar.gz --strip-components=1 -C /var/www/localhost/phpmyadmin
rm -rf phpMyAdmin-5.1.0-all-languages.tar.gz

## Moving our modified config php file from the srcs
mv ./config.inc.php /var/www/localhost/phpmyadmin

# WordPress setup

## Following this guide: https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-nginx-mariadb-and-php-on-debian-10

mkdir /var/www/localhost/wordpress
wget http://wordpress.org/latest.tar.gz
tar -zxf latest.tar.gz --strip-components=1 -C /var/www/localhost/wordpress
rm -rf latest.tar.gz
mv ./wp-config.php /var/www/localhost/wordpress

## Installing new php extensions used by WordPress
apt-get -y install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip

## Do the basic WP page setup
## We need the wp commands. For that I followed this guide https://www.liquidweb.com/kb/install-wp-cli/
wget -O wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp
mv wp /usr/local/bin/
wp core install --allow-root --url=localhost/wordpress --path=/var/www/localhost/wordpress/ --title="Hello world!" --admin_name=admin --admin_password=password --admin_email=admin@admin.com

# Finally, start php and nginx
service php7.3-fpm start
service nginx start

# Sleep infinity
while true;
	do sleep 10000;
done
