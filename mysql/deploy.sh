#!/usr/bin/env bash

echo $*
#判断传参
if [ $# -ne 2 ]
    then
        echo '这个脚本需要传递两个参数第一个参数是用于配置root账户host，第二个是root账户的初始密码'
        exit
    else
        createDirectory
        getDataInitSql
        getDockerComposeTemplateFile
        deployUp
        exit
fi

# 创建目录
function createDirectory {
mkdir -p $PWD/config && mkdir -p $PWD/data && mkdir -p $PWD/logs && mkdir -p $PWD/init.d
}
# 拉取编排模版文件
function getDockerComposeTemplateFile{
    wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/structure-projects/structure-compose/1.0.1.RELEASE/mysql/docker-compose.yml -O  $PWD/docker-compose.yml
}
# 拉取数据库初始sql
function getDataInitSql{
    wget https://mirror.ghproxy.com/https://raw.githubusercontent.com/structure-projects/structure-compose/1.0.1.RELEASE/mysql/master.sql -O ./init.d/init.sql
}

# 替换参数
function replace{
 sed -i s/"REPLACE_HOST"/"$1"/g $PWD/docker-compose.yml && sed -i s/"REPLACE_PASSWORD"/"$2"/g $PWD/docker-compose.yml
}

# 执行部署命令
function deployUp{
    docker-compose -f $PWD/docker-compose.yml up -d
}




