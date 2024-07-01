# 基础服务部署文档
## Docker 环境安装

### 卸载旧版

```shell
yum remove -y docker \
           docker-client \
           docker-client-latest \
           docker-common \
           docker-latest \
           docker-latest-logrotate \
           docker-logrotate \
           docker-selinux \
           docker-engine-selinux \
           docker-engine
```

### 设置安装源

```shell
yum -y install yum-utils 
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```

### 安装Docker

```shell
yum makecache fast
yum list docker-ce --showduplicates | sort -r
yum -y install docker-ce-20.10.3
```

### 启动Docker设置开机自动启动

```shell
systemctl start docker & systemctl enable docker
```

### 修改docker仓库配置

```shell
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://fgsh6ko1.mirror.aliyuncs.com"]
}
EOF

systemctl daemon-reload
systemctl restart docker
```

## 安装docker-compose
### 下载docker-compose


- 当前git库下载(推荐)
```shell
curl -L https://get.daocloud.io/docker/compose/releases/download/v2.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
```

- 官方下载
```shell
curl -L https://get.daocloud.io/docker/compose/releases/download/v2.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
```

### 添加执行权限

```shell
chmod +x /usr/local/bin/docker-compose
```

