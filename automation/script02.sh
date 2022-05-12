#!/bin/bash
echo "Started script 02" >> /tmp/logscript2.txt
## Secure the MariaDB installation
sudo systemctl enable mariadb
sudo systemctl start mariadb
mysql_secure_installation <<EOF
y
mssqlpass
mssqlpass
y
y
y
y
EOF

## Create a database and a database user for MediaWiki
mysql -u root --password=mssqlpass -e "CREATE USER 'wiki'@'localhost' IDENTIFIED BY 'wikiPassword';"
mysql -u root --password=mssqlpass -e "CREATE DATABASE wikidatabase;"  
mysql -u root --password=mssqlpass -e "GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'localhost';"
mysql -u root --password=mssqlpass -e "FLUSH PRIVILEGES;"


