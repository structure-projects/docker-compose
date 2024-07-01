#!/bin/bash
host=%
password=123456
composeVersion=1.0.1.RELEASE
proxy=https://mirror.ghproxy.com/
imageRepository=mysql
imagesVersion=8.0.25
masterHost=mysql-master


mkdir -p $PWD/mysql-master/config && mkdir -p $PWD/mysql-master/data && mkdir -p $PWD/mysql-master/logs && mkdir -p $PWD/mysql-slave/init.d;
mkdir -p $PWD/mysql-slave/config && mkdir -p $PWD/mysql-slave/data && mkdir -p $PWD/mysql-slave/logs && mkdir -p $PWD/mysql-slave/init.d;
curl ${proxy}https://raw.githubusercontent.com/structure-projects/docker-compose/${composeVersion}/mysql/master.sql -o $PWD/mysql-master/init.d/init.sql;
curl ${proxy}https://raw.githubusercontent.com/structure-projects/docker-compose/${composeVersion}/mysql/slave.sql -o $PWD/mysql-slave/init.d/init.sql;
curl ${proxy}https://raw.githubusercontent.com/structure-projects/docker-compose/${composeVersion}/mysql/master-slave.yml.yml -o $PWD/docker-compose.yml;
sed -i s/"REPLACE_HOST"/"${host}"/g $PWD/docker-compose.yml && sed -i s/"REPLACE_PASSWORD"/"${password}"/g $PWD/docker-compose.yml;
sed -i s/"IMAGE_REPOSITORY"/"${imageRepository}"/g $PWD/docker-compose.yml && sed -i s/"IMAGE_VERSION"/"${imagesVersion}"/g $PWD/docker-compose;
sed -i s/"REPLACE_MASTER_HOST"/"${masterHost}"/g $PWD/docker-compose.yml && sed -i s/"REPLACE_PASSWORD"/"${password}"/g $PWD/mysql-slave/init.d/init.sql;
docker-compose -f $PWD/docker-compose.yml up -d;