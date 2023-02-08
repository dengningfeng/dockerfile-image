# 构建流程
es集群3节点镜像

## 相关文件路径
| 文件           | 路径                                                                                                |
|:-------------|:--------------------------------------------------------------------------------------------------|
| es           | /usr/share/elasticsearch                                                                          | 
| es配置文件地址     | /usr/share/elasticsearch/config/elasticsearch.yml                                                                                                  |
| es日志地址       |  /var/log/es.log                                                                                                     |

## 端口
| 端口    | 说明             |
|:------|:---------------|
| 9200  | es http客户端连接端口 | 
| 9300  | es tcp连接端口     | 

## 账号密码
| 账号  | 密码            |
|:----|:--------------|
| es  | es | 

## 容器构建运行

### 1、进入Dockerfile文件同级目录下

### 2、构建镜像
```shell
docker build -t dev/elasticsearch:8.1.0 .
```
### 3、运行容器
```shell
docker run -d -p 9200:9200 -p 9300:9300 -e NODE_NAME="node-1" -e NODE_1="${物理机ip}:9300" -e NODE_2="${物理机ip}:9400" -e NODE_3="${物理机ip}:9500" --name es-node-1 elasticsearch:8.1.0

docker run -d -p 9201:9200 -p 9400:9300 -e NODE_NAME="node-2" -e NODE_1="${物理机ip}:9300" -e NODE_2="${物理机ip}:9400" -e NODE_3="${物理机ip}:9500" --name es-node-2 elasticsearch:8.1.0

docker run -d -p 9202:9200 -p 9500:9300 -e NODE_NAME="node-3" -e NODE_1="${物理机ip}:9300" -e NODE_2="${物理机ip}:9400" -e NODE_3="${物理机ip}:9500" --name es-node-3 elasticsearch:8.1.0
```