#!/bin/bash
options=$(getopt -o h:u:p:v:i:r:proxy:port --long host:,user:,password:,version:,image:,repository:,proxy:port -- "$@")
eval set -- "$options"
echo "The nacos service is deployed !output parameter $@"
while true; do
  case $1 in
  	-h | --host) shift; host=$1 ; shift ;;
    -u | --user) shift; user=$1 ; shift ;;
    -p | --password) shift; password=$1 ; shift ;;
    -v | --version) shift; version=$1 ; shift ;;
    -i | --image) shift; image=$1 ; shift ;;
    -r | --repository) shift; repository=$1 ; shift ;;
    -proxy | --proxy) proxy=$1; shift ;;
    -port | --port) port=$1; shift ;;
    --) shift ; break ;;
    *) echo "Invalid option: $1" exit 1 ;;
  esac
done
if [ -z "$host" ]; then
    echo "replace the host default!";
    host='mysql';
fi
if [ -z "$user" ]; then
    echo "replace the user default!";
    user='root';
fi
if [ -z "$password" ]; then
    echo "replace the password default!";
    password=123456;
fi
if [ -z "$version" ]; then
    echo "replace the version default!";
    version=1.0.1.RELEASE;
fi
if [ -z "$proxy" ]; then
    echo "replace the proxy default!";
    proxy=https://mirror.ghproxy.com/;
fi
if [ -z "$port" ]; then
    echo "replace the port default!";
    port=3306;
fi
if [ -z "$image" ]; then
    echo "replace the image default!";
    image=nacos/nacos-server:2.0.3;
fi
if [ -z "$repository" ]; then
    echo "replace the repository default!";
    repository=https://raw.githubusercontent.com/structure-projects/docker-compose;
fi
echo "Output execution parameter host=$host port=$port user=$user password=$password version=$version proxy=$proxy image=$image repository=$repository";
echo "make directory";
mkdir -p $PWD/logs && mkdir -p $PWD/data;
curl ${proxy}${repository}/${version}/nacos/docker-compose.yml -o $PWD/docker-compose.yml;
echo "Replace the host, password, and image of the docker-compose file";

sed -i s/"DB_HOST"/"${host}"/g $PWD/docker-compose.yml && sed -i s/"DB_USER"/"${user}"/g $PWD/docker-compose.yml;
sed -i s/"DB_PORT"/"${port}"/g $PWD/docker-compose.yml && sed -i s/"DB_PASSWORD"/"${password}"/g $PWD/docker-compose.yml;

docker-compose -f $PWD/docker-compose.yml up -d;


