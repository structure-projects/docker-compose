#!/bin/bash
options=$(getopt -o h:p:v:i:r:proxy --long host:,password:,version:,image:,repository:,proxy -- "$@")
eval set -- "$options"
echo "The mysql service is deployed !output parameter $@"
while true; do
  case $1 in
  	-h | --host) shift; host=$1 ; shift ;;
    -p | --password) shift; password=$1 ; shift ;;
    -v | --version) shift; version=$1 ; shift ;;
    -v | --image) shift; image=$1 ; shift ;;
    -v | --repository) shift; repository=$1 ; shift ;;
    -proxy | --proxy) proxy=$1; shift ;;
    --) shift ; break ;;
    *) echo "Invalid option: $1" exit 1 ;;
  esac
done
if [ -z "$host" ]; then
    echo "replace the host default!";
    host='%';
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
if [ -z "$image" ]; then
    echo "replace the image default!";
    image=mysql:8.0.25;
fi
if [ -z "$repository" ]; then
    echo "replace the repository default!";
    repository=https://raw.githubusercontent.com/structure-projects/docker-compose;
fi
echo "Output execution parameter host=$host password=$password version=$version proxy=$proxy image=$image repository=$repository";
echo "make directory";
mkdir -p $PWD/config && mkdir -p $PWD/data && mkdir -p $PWD/logs && mkdir -p $PWD/init.d;
echo "download init sql file !";
curl ${proxy}${repository}/${version}/mysql/master.sql -o $PWD/init.d/init.sql;
echo "download docker-compose file !";
curl ${proxy}${repository}/${version}/mysql/docker-compose.yml -o $PWD/docker-compose.yml;
echo "Replace the host, password, and image of the docker-compose file";
sed -i s/"REPLACE_HOST"/"${host}"/g $PWD/docker-compose.yml && sed -i s/"REPLACE_PASSWORD"/"${password}"/g $PWD/docker-compose.yml;
sed -i s/"REPLACE_IMAGE"/"${image}"/g $PWD/docker-compose.yml;
docker-compose -f $PWD/docker-compose.yml up -d;


