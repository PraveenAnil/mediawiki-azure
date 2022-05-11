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
sudo dnf module reset php -y
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

## Replace value in Script02
sed -i "s|mssqlpass|$mssqlpass|" script02.sh
sed -i "s|wikiPassword|$wikiPassword|" script02.sh

sudo bash script02.sh


