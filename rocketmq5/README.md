# rocketmq:5镜像说明
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

