#!bin/bash
nohup /usr/share/kibana/bin/kibana >> /usr/share/kibana/logs/kibana.log 2>&1 &
nohup /usr/share/elasticsearch/bin/elasticsearch >> /usr/share/elasticsearch/logs/es.log 2>&1  &

