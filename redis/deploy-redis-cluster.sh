#!/bin/bash
host=%
password=123456
composeVersion=1.0.1.RELEASE
proxy=https://mirror.ghproxy.com/
hostMachineIp=$1
clusterReplicas=6
#判断传参
if [ $# -ne 1 ]
   then
       echo "需要传递一个主机的IP地址";
       exit
   else
        curl ${proxy}https://raw.githubusercontent.com/structure-projects/docker-compose/${composeVersion}/redis/redis-cluster.yml -o $PWD/docker-compose.yml;
        sed -i s/"HOST_MACHINE_IP"/"${hostMachineIp}"/g $PWD/docker-compose.yml &&  sed -i s/"PASSWORD"/"${password}"/g $PWD/docker-compose.yml
        for ((i=0; i<$clusterReplicas; i++))
        do
          mkdir -p $PWD/node-${i}/conf && mkdir -p $PWD/node-${i}/data;
          touch $PWD/nodes.conf $PWD/node-${i}/conf/nodes.conf
          sudo chmod -R 777 $PWD/node-${i}/conf/
        done
        docker network create redis-cluster-net;
        docker-compose -f $PWD/docker-compose.yml up -d;
       exit
fi


