#!/bin/bash
mssqlpass=${1}
wikiPassword=${2}

sudo yum install centos-release-scl -y

## Install Apache
sudo yum install httpd -y
sudo systemctl enable httpd.service
sudo systemctl start httpd.service

## Add Extra Packages for Enterprise Linux (EPEL) and the Remi repository
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
sudo dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

## Install PHP from the Remi repository
sudo dnf module reset php
sudo dnf module install php:remi-8.0 -y

## Install the php module to support the use of the MariaDB 
sudo dnf install php-mysqlnd php php-gd php-xml php-mbstring php-json -y
sudo yum install php-intl -y

## Restart apache service
sudo systemctl restart httpd

## Install MariaDB
sudo yum install mariadb-server mariadb -y

## Enable and start the MariaDB service
sudo systemctl enable mariadb
sudo systemctl start mariadb

## Secure the MariaDB installation
sudo mysql_secure_installation <<EOF
y
$mssqlpass
$mssqlpass
y
y
y
y
EOF

## Create a database and a database user for MediaWiki
sudo mysql -u root --password=$mssqlpass -e "CREATE USER 'wiki'@'localhost' IDENTIFIED BY '$wikiPassword';"#replace "wiki" and "Testing12345" with your desired credential
sudo mysql -u root --password=$mssqlpass -e "CREATE DATABASE wikidatabase;"  
sudo mysql -u root --password=$mssqlpass -e "GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'localhost';"
sudo mysql -u root --password=$mssqlpass -e "FLUSH PRIVILEGES;"

## Download and Extract the MediaWiki Files
cd /home
sudo wget https://releases.wikimedia.org/mediawiki/1.37/mediawiki-1.37.2.tar.gz
sudo mv mediawiki-1.37.2.tar.gz /var/www/html
cd /var/www/html/
sudo tar xvzf /var/www/html/mediawiki-1.37.2.tar.gz
mv /var/www/html/mediawiki-1.37.2 /var/www/html/w

## Restart apache service
sudo systemctl restart httpd

