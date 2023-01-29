# rocketmq:5.0.0镜像说明
包含nameServer和broker

## 相关文件路径
| 文件                | 路径           |
|:------------------|:-------------|
| java              | /usr/lib/jvm/jdk8 | 
| rocketmq          | /usr/local/rocketmq  | 
| broker启动jvm参数配置地址 | /usr/local/rocketmq/bin/runbroker.sh  |
| nameServer日志位置    |          /var/log/rocketmq.d/namesrv.log                             |
| broker日志位置        |    /var/log/rocketmq.d/broker.log                                                                  |


## 端口
| 端口    | 说明           |
|:------|:-------------|
| 9876  | rocketmq连接端口 | 
| 10909 | broker 通讯端口  | 
| 10911 | broker 通讯端口  |


## 环境变量
| 环境变量 | 说明           | 默认值            |
|:-----|:-------------|:---------------|
| NAMESRV_ADDR  | nameServer地址 | 127.0.0.1:9876 |
| NAMESRV_ADDR  | broker ip地址  | 127.0.0.1      |

## 容器构建运行
### 1、进入Dockerfile文件同级目录下

### 2、执行构建命令
```shell
docker build -t dev/rocketmq:5.0.0 .
```
### 3、运行容器
```shell
docker run -d -p 9876:9876 -p 10909:10909 -p 10911:10911 --name=dev-rocketmq dev/rocketmq:5.0.0
```
