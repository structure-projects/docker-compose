#!/bin/bash
host=%
password=123456
composeVersion=1.0.1.RELEASE
proxy=https://mirror.ghproxy.com/
hostMachineIp=$1

mkdir -p $PWD/conf && mkdir -p $PWD/data;
curl ${proxy}https://raw.githubusercontent.com/structure-projects/docker-compose/${composeVersion}/redis/redis.conf -o $PWD/config/redis.conf;
curl ${proxy}https://raw.githubusercontent.com/structure-projects/docker-compose/${composeVersion}/redis/docker-compose.yml -o $PWD/docker-compose.yml;
sed -i s/"REPLACE_HOST"/"${host}"/g $PWD/config/redis.conf && sed -i s/"REPLACE_PASSWORD"/"${password}"/g $PWD/config/redis.conf;
docker-compose -f $PWD/docker-compose.yml up -d;


