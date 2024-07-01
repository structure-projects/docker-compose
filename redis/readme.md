## 进入任意节点
```shell
   docker exec -it redis-0 /bin/sh
```
## 集群初始化操作
这里的ip要切换成自己的IP
```shell
    redis-cli --cluster create \
 01   192.168.1.231:7000 \
    192.168.1.231:7001 \
    192.168.1.231:7002 \
    192.168.1.231:7003 \
    192.168.1.231:7004 \
    192.168.1.231:7005 \
     --cluster-replicas 1
```
输入yes
如果有访问密码请输入 -a 
## 查看集群
```shell
      redis-cli cluster nodes;
```
```shell
      redis-cli cluster info;
```
## 测试集群
```shell
     redis-cli -c -h 192.168.1.231 -p 7000
```
### 设置值
```shell
     set test abc
```
### 获取值
```shell
     get test
```
### 切换节点获取值
```shell
     redis-cli -c -h 192.168.1.231 -p 7001
```
### 获取值
```shell
     get test
```