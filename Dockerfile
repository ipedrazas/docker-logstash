#
#
#   Dockerfile Logstash - ipedrazas@gmail.com
#

FROM dockerfile/java:oracle-java7

MAINTAINER Ivan Pedrazas<ipedrazas@gmail.com>

RUN cd /opt && wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz && tar zxf logstash-1.4.2.tar.gz && rm logstash-1.4.2.tar.gz
RUN ln -s /opt/logstash-1.4.2 /opt/logstash
ADD conf/logstash.conf /data/logstash.conf
RUN rm -rf /tmp/*
RUN sudo mkdir -p /etc/pki/tls/certs
RUN sudo mkdir /etc/pki/tls/private
RUN cd /etc/pki/tls; \
    sudo openssl req -x509 -batch -nodes -days 3650 -newkey rsa:2048 \
    -keyout private/logstash-forwarder.key \
    -out certs/logstash-forwarder.crt

ADD conf/01-lumberjack-input.conf /etc/logstash/conf.d/01-lumberjack-input.conf
ADD conf/10-syslog.conf /etc/logstash/conf.d/10-syslog.conf
ADD conf/30-lumberjack-output.conf /etc/logstash/conf.d/30-lumberjack-output.conf


EXPOSE 514
EXPOSE 9292

CMD /opt/logstash/bin/logstash \
    agent \
    --config /data/logstash.conf \
    -- \
    web




# docker run -d -p 9292:9292 -v /data/logstash:/data ipedrazas/logstash

