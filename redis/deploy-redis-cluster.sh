#!/bin/bash
host=%
password=123456
composeVersion=1.0.1.RELEASE
proxy=https://mirror.ghproxy.com/
hostMachineIp=$1
#判断传参
if [ $# -ne 1 ]
   then
       echo "需要传递一个主机的IP地址";
       exit
   else
        mkdir -p $PWD/node-0/conf && mkdir -p $PWD/node-0/data;
        mkdir -p $PWD/node-1/conf && mkdir -p $PWD/node-1/data;
        mkdir -p $PWD/node-2/conf && mkdir -p $PWD/node-2/data;
        mkdir -p $PWD/node-3/conf && mkdir -p $PWD/node-3/data;
        mkdir -p $PWD/node-4/conf && mkdir -p $PWD/node-4/data;
        mkdir -p $PWD/node-5/conf && mkdir -p $PWD/node-5/data;
        curl ${proxy}https://raw.githubusercontent.com/structure-projects/docker-compose/${composeVersion}/redis/redis-cluster.yml -o $PWD/docker-compose.yml;
        curl ${proxy}https://raw.githubusercontent.com/structure-projects/docker-compose/${composeVersion}/redis/nodes.conf -o $PWD/nodes.conf;
        sed -i s/"HOST_MACHINE_IP"/"${hostMachineIp}"/g $PWD/docker-compose.yml &&  sed -i s/"PASSWORD"/"${password}"/g $PWD/docker-compose.yml
        cp $PWD/nodes.conf $PWD/node-0/conf/ && cp $PWD/nodes.conf $PWD/node-1/conf/;
        cp $PWD/nodes.conf $PWD/node-2/conf/ && cp $PWD/nodes.conf $PWD/node-3/conf/;
        cp $PWD/nodes.conf $PWD/node-4/conf/ && cp $PWD/nodes.conf $PWD/node-5/conf/;
        sudo chmod -R 777 $PWD/node-0/conf/ && sudo chmod -R 777 $PWD/node-1/conf/;
        sudo chmod -R 777 $PWD/node-2/conf/ && sudo chmod -R 777 $PWD/node-3/conf/;
        sudo chmod -R 777 $PWD/node-4/conf/ && sudo chmod -R 777 $PWD/node-5/conf/;
        rm -f $PWD/nodes.conf;
        docker network create redis-cluster-net;
        docker-compose -f $PWD/docker-compose.yml up -d;
       exit
fi


