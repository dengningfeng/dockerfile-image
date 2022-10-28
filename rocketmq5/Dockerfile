FROM king019/rocketmq:latest@sha256:698381b0826274389ec0ac16dd69c724e386a1d5a4030dc164e0e9263a9e9091 as rocketmq
FROM debian:10.12-slim@sha256:4d478ecf606675c4e697fabecb9ee2007ddcd1992ab4ad046eb495565296810d
# 环境变量设置
ENV NAMESRV_ADDR='127.0.0.1:9876' BROKER_IP='localhost'
ARG JDK_PATH=/usr/lib/jvm/jdk8
ENV JAVA_HOME=${JDK_PATH} PATH=${JDK_PATH}/bin:$PATH
# 软件源更新设置
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
# java相关设置
COPY --from=rocketmq /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.345.b01-1.el8_6.aarch64 /usr/lib/jvm/jdk8
COPY --from=rocketmq /etc/java/java-1.8.0-openjdk/java-1.8.0-openjdk-1.8.0.345.b01-1.el8_6.aarch64/lib/calendars.properties /etc/java/java-1.8.0-openjdk/java-1.8.0-openjdk-1.8.0.345.b01-1.el8_6.aarch64/lib/calendars.properties
COPY --from=rocketmq /etc/java/java-1.8.0-openjdk/java-1.8.0-openjdk-1.8.0.345.b01-1.el8_6.aarch64/lib/logging.properties /etc/java/java-1.8.0-openjdk/java-1.8.0-openjdk-1.8.0.345.b01-1.el8_6.aarch64/lib/logging.properties
COPY --from=rocketmq /usr/share/javazi-1.8/tzdb.dat /usr/share/javazi-1.8/tzdb.dat
RUN rm -rf /usr/lib/jvm/jdk8/jre/lib/security/policy/unlimited/*
COPY unlimit/* /usr/lib/jvm/jdk8/jre/lib/security/policy/unlimited/
# rocketmq设置
RUN mkdir -p /usr/local/rocketmq && mkdir -p /var/log/rocketmq.d
COPY --from=rocketmq /opt/soft/rocketmq /usr/local/rocketmq
RUN sed -i '/.*-server -Xms*/c\JAVA_OPT="${JAVA_OPT} -server -Xms256m -Xmx4g -Xmn128m"' /usr/local/rocketmq/bin/runbroker.sh
# 最终启动文件设置
COPY entrypoint.sh /etc/local/bin/entrypoint.sh
RUN chmod 777 /etc/local/bin/entrypoint.sh
EXPOSE 9876 10909 10911
WORKDIR /usr/local/rocketmq
ENTRYPOINT sh /etc/local/bin/entrypoint.sh && sleep infinity