#!/bin/bash

options=$(getopt -o a:e:f:h --long args:,env:,filepath:,help -- "$@")
eval set -- "$options"
version=1.0.1
# 提取选项和参数
while true; do
  case $1 in
  	-a | --args) shift; args=$1 ; shift ;;
    -e | --env) shift; env=$1 ; shift ;;
    -r | --repository) shift; filepath=$1 ; shift ;;
    -p | --proxy) help=$1; shift ;;
    --) shift ; break ;;
    *) echo "Invalid option: $1" exit 1 ;;
  esac
done

function funHelp(){
    echo "command";
    echo "apply       应用部署";
    echo "list        查看应用列表";
    echo "version     查看版本";
    echo "help        帮助描述";
    echo "command apply     参数描述";
    echo " -a  --args       参数";
    echo " -e  --env        环境变量";
    echo " -n  --name       指定应用名称";
    echo " -v  --version    指定应用版本";
    echo " -p  --proxy      指定代理地址";
    echo " -r  --repository 指定仓库地址";
}
function error(){
    funHelp
    exit 1
}
function funList(){
    echo "服务列表";
}
function applyService(){
    echo "部署应用";
}
function showVersion(){
    echo "$version";
}
#指令解析
case "$1" in
        apply) applyService;;
        list) funList;;
        version) showVersion;;
        help) funHelp;;
        *) echo "指令参数错误"; funHelp; exit 1;;
esac



