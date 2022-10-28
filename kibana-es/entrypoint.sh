#!bin/bash
nohup /usr/share/elasticsearch/bin/elasticsearch >> /var/log/es.log 2>&1  &
nohup /usr/share/kibana/bin/kibana >> /var/log/kibana.log 2>&1 &

