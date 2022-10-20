FROM elasticsearch:8.1.0@sha256:56bfbba13046c12da036054f4d3629afaa660e98e89a11ab36d14cf582f1fa44 as es
FROM kibana:8.1.0@sha256:0e217fee78825de6ef6b2bb06526909e74a60718fcc3d4a5f1e36b6c427c006d as kibana
FROM debian:10.12-slim@sha256:4d478ecf606675c4e697fabecb9ee2007ddcd1992ab4ad046eb495565296810d
RUN chmod 777 /etc/apt/sources.list
RUN echo \
        deb http://mirrors.163.com/debian/ buster main non-free contrib \
        deb http://mirrors.163.com/debian/ buster-updates main non-free contrib \
        deb http://mirrors.163.com/debian/ buster-backports main non-free contrib \
        deb http://mirrors.163.com/debian-security/ buster/updates main non-free contrib \
        deb-src http://mirrors.163.com/debian/ buster main non-free contrib \
        deb-src http://mirrors.163.com/debian/ buster-updates main non-free contrib \
        deb-src http://mirrors.163.com/debian/ buster-backports main non-free contrib \
        deb-src http://mirrors.163.com/debian-security/ buster/updates main non-free contrib \
        > /etc/apt/sources.list && \
        apt-get update && \
        apt-get install -y --no-install-recommends vim sudo net-tools
RUN useradd --create-home --no-log-init --shell /bin/bash es
RUN adduser es sudo
RUN echo 'es:es' | chpasswd
RUN mkdir -p /usr/share/elasticsearch
COPY --from=es  /usr/share/elasticsearch /usr/share/elasticsearch
RUN echo > /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'xpack.security.enabled: false' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'xpack.security.enrollment.enabled: false' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'network.host: 0.0.0.0' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'node.name: node-1' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'cluster.initial_master_nodes: ["node-1"]' >> /usr/share/elasticsearch/config/elasticsearch.yml
EXPOSE 9200 9300
RUN mkdir -p /usr/share/elasticsearch/plugins/ik
COPY ./plugins/ik /usr/share/elasticsearch/plugins/ik
RUN chmod -R 777 /usr/share/elasticsearch
COPY --from=kibana /usr/share/kibana /usr/share/kibana
RUN echo > /usr/share/kibana/config/kibana.yml && \
    echo 'server.host: "0.0.0.0" ' >> /usr/share/kibana/config/kibana.yml && \
    echo 'server.shutdownTimeout: "5s" ' >> /usr/share/kibana/config/kibana.yml && \
    echo 'elasticsearch.hosts: [ "http://127.0.0.1:9200" ] ' >> /usr/share/kibana/config/kibana.yml
RUN chmod -R 777 /usr/share/kibana
EXPOSE 5601
COPY entrypoint.sh /etc/local/bin/entrypoint.sh
RUN chmod 777 /etc/local/bin/entrypoint.sh
USER es
ENTRYPOINT sh /etc/local/bin/entrypoint.sh && sleep infinity
