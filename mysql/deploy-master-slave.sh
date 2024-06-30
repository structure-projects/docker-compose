#!/bin/bash
host=$1
password=$2
master_host=$3
version=1.0.1.RELEASE
proxy=https://mirror.ghproxy.com/
echo "打印参数: $*"
#判断传参
if [ $# -ne 3 ]
    then
        echo "参数错误";
    else
        echo "执行脚本"
        mkdir -p $PWD/config && mkdir -p $PWD/data && mkdir -p $PWD/logs && mkdir -p $PWD/init.d
        wget ${proxy}https://raw.githubusercontent.com/structure-projects/docker-compose/${version}/mysql/master.sql -O ./init.d/init.sql
        wget ${proxy}https://raw.githubusercontent.com/structure-projects/docker-compose/${version}/mysql/docker-compose.yml -O $PWD/docker-compose.yml;
        sed -i s/"REPLACE_HOST"/"${host}"/g $PWD/docker-compose.yml && sed -i s/"REPLACE_PASSWORD"/"${password}"/g $PWD/docker-compose.yml
        docker-compose -f $PWD/docker-compose.yml up -d
        exit
fi


