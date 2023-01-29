FROM elasticsearch:8.1.0@sha256:cb74057b1647351b128a4417510c6ce398d8e5d5db16be2bc305fbafaf2f4a87 as es
FROM debian:10.12-slim@sha256:61ba33ad17fa49d1dc4e5f09c1d957bad967d8bdebde43f9fd7a255cc3ac595b
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
        apt-get install -y --no-install-recommends vim sudo net-tools && \
        apt-get install procps -y

RUN echo 'es soft nofile 65536' >> /etc/security/limits.conf && echo 'es hard nofile 65536' >> /etc/security/limits.conf

RUN useradd --create-home --no-log-init --shell /bin/bash es
RUN adduser es sudo
RUN echo 'es:es' | chpasswd
RUN mkdir -p /usr/share/elasticsearch

COPY --from=es  /usr/share/elasticsearch /usr/share/elasticsearch
RUN echo > /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'cluster.name: my-application' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'node.name: ${NODE_NAME}' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'network.host: 0.0.0.0' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'http.port: 9200' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'transport.port: 9300' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'discovery.seed_hosts: ["${NODE_1}","${NODE_2}","${NODE_3}"]' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'cluster.initial_master_nodes: ["node-1", "node-2","node-3"]' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'path.data: /usr/share/elasticsearch/data' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'path.logs: /usr/share/elasticsearch/logs' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'xpack.security.enabled: false' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'xpack.security.enrollment.enabled: false' >> /usr/share/elasticsearch/config/elasticsearch.yml 
# 根据实际使用内存调整
RUN echo '-Xms1g' >> /usr/share/elasticsearch/config/jvm.options && \
    echo '-Xmx1g' >> /usr/share/elasticsearch/config/jvm.options

EXPOSE 9200 9300
RUN mkdir -p /usr/share/elasticsearch/plugins/ik
COPY ./plugins/ik /usr/share/elasticsearch/plugins/ik
RUN chmod -R 777 /usr/share/elasticsearch
RUN touch /var/log/es.log && chmod 777 /var/log/es.log

COPY entrypoint.sh /etc/local/bin/entrypoint.sh
RUN chmod 777 /etc/local/bin/entrypoint.sh
USER es
ENTRYPOINT sh /etc/local/bin/entrypoint.sh && sleep infinity
