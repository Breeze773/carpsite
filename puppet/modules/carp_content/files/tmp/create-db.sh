#!/bin/bash

MYSQL=`which mysql`
mysqlRootPw=$(cat /vagrant/password.txt)
schemaName='drupal6'
userName="${schemaName}"

Q1="DROP DATABASE IF EXISTS ${schemaName};"
Q2="CREATE DATABASE IF NOT EXISTS ${schemaName} CHARACTER SET UTF8;"
Q3="GRANT USAGE ON ${schemaName}.* TO '${userName}'@'localhost' IDENTIFIED BY '${mysqlRootPw}'; "
Q4="GRANT ALL PRIVILEGES ON ${schemaName}.* TO ${userName}@localhost;"
Q5="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}${Q5}"


$MYSQL -uroot -p${mysqlRootPw} -e "${SQL}"