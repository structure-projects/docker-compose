#!/bin/bash
host=%
password=123456
composeVersion=1.0.1.RELEASE
proxy=https://mirror.ghproxy.com/
network=structure-network
imageRepository=mysql
imagesVersion=8.0.25

mkdir -p $PWD/config && mkdir -p $PWD/data && mkdir -p $PWD/logs && mkdir -p $PWD/init.d;
wget ${proxy}https://raw.githubusercontent.com/structure-projects/docker-compose/${composeVersion}/mysql/master.sql -O ./init.d/init.sql;
wget ${proxy}https://raw.githubusercontent.com/structure-projects/docker-compose/${composeVersion}/mysql/docker-compose.yml -O $PWD/docker-compose.yml;
sed -i s/"REPLACE_HOST"/"${host}"/g $PWD/docker-compose.yml && sed -i s/"REPLACE_PASSWORD"/"${password}"/g $PWD/docker-compose.yml;
sed -i s/"IMAGE_REPOSITORY"/"${imageRepository}"/g $PWD/docker-compose.yml && sed -i s/"IMAGE_VERSION"/"${imagesVersion}"/g $PWD/docker-compose.yml;
sed -i s/"REPLACE_NETWORK"/"${network}"/g $PWD/docker-compose.yml;
docker-compose -f $PWD/docker-compose.yml up -d;


