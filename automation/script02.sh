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


