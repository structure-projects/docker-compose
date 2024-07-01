
## 集群初始化操作

```shell
        docker exec -it redis-0 /bin/sh;
        redis-cli  --cluster create \
        192.168.1.231:7000 \
        192.168.1.231:7001 \
        192.168.1.231:7002 \
        192.168.1.231:7003 \
        192.168.1.231:7004 \
        192.168.1.231:7005 \
         --cluster-replicas 1
        yes
         redis-cli -a 123456 cluster nodes;
         redis-cli -a 123456 cluster info;
         exit
```