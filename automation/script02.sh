#!/bin/bash

## Secure the MariaDB installation
sudo mysql_secure_installation <<EOF
y
mssqlpass
mssqlpass
y
y
y
y
EOF

## Create a database and a database user for MediaWiki
sudo mysql -u root --password=mssqlpass -e "CREATE USER 'wiki'@'localhost' IDENTIFIED BY 'wikiPassword';"
sudo mysql -u root --password=mssqlpass -e "CREATE DATABASE wikidatabase;"  
sudo mysql -u root --password=mssqlpass -e "GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'localhost';"
sudo mysql -u root --password=mssqlpass -e "FLUSH PRIVILEGES;"

## Download and Extract the MediaWiki Files
cd /home
sudo wget https://releases.wikimedia.org/mediawiki/1.37/mediawiki-1.37.2.tar.gz
sudo mv mediawiki-1.37.2.tar.gz /var/www/html
cd /var/www/html/
sudo tar xvzf /var/www/html/mediawiki-1.37.2.tar.gz
mv /var/www/html/mediawiki-1.37.2 /var/www/html/w

## Restart apache service
sudo systemctl restart httpd
