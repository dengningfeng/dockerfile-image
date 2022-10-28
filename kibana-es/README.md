# 构建流程
包含es和kibana镜像


## 相关文件路径
| 文件           | 路径                                                                                                |
|:-------------|:--------------------------------------------------------------------------------------------------|
| es           | /usr/share/elasticsearch                                                                          | 
| kibana       | /usr/share/kibana                                                                                 | 
| es配置文件地址     | /usr/share/elasticsearch/config/elasticsearch.yml                                                                                                  |
| kibana配置文件地址 | /usr/share/kibana/config/kibana.yml                                                                   |

## 端口
| 端口    | 说明             |
|:------|:---------------|
| 9200  | es http客户端连接端口 | 
| 9300  | es tcp连接端口     | 
| 5601 | kibana连接端口     |

## 账号密码
| 账号  | 密码            |
|:----|:--------------|
| es  | es | 

## 容器构建运行

### 1、进入Dockerfile文件同级目录下

### 2、构建镜像
```shell
docker build -t dev/kibana-es:8.1.0 .
```

### 3、运行容器
```shell
docker run -d -p 9200:9200 -p 9300:9300 -p 5601:5601 --name=dev-es dev/kibana-es:8.1.0
```