echo namesrvAddr=${NAMESRV_ADDR} >> /usr/local/rocketmq/conf/broker.conf
echo brokerIP1=${BROKER_IP} >> /usr/local/rocketmq/conf/broker.conf
nohup sh /usr/local/rocketmq/bin/mqnamesrv > /var/log/rocketmq.d/namesrv.log 2>&1 &
nohup sh /usr/local/rocketmq/bin/mqbroker -n localhost:9876 -c /usr/local/rocketmq/conf/broker.conf autoCreateTopicEnable=true > /var/log/rocketmq.d/broker.log 2>&1 &