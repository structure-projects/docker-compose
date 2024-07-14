# docker-compose
这个项目主要是使用docker-compose部署一些基础服务的文档和脚本

## 容器环境部署
### Docker 在线安装
### Docker 离线安装
## 服务部署
所有的服务流程都是一样的，这里只用mysql作为演示，其余的只需要更换部署的shell脚本下载地址即可
### 下载脚本文件
```shell
curl https://mirror.ghproxy.com/https://raw.githubusercontent.com/structure-projects/docker-compose/1.0.1.RELEASE/mysql/deploy.sh -o deploy.sh
```
### 添加执行权限
```shell
chmod +x deploy.sh 
```
### 部署前编辑
执行之前可以查看下脚本有么有需要修改的地方
```shell
vim deploy.sh 
```
### 执行脚本
```shell
sh deploy.sh 
```