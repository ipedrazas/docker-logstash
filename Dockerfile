#
#
#   Dockerfile Logstash - ipedrazas@gmail.com
#

FROM dockerfile/java:oracle-java7

MAINTAINER Ivan Pedrazas<ipedrazas@gmail.com>

RUN cd /opt && wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz && tar zxf logstash-1.4.2.tar.gz && rm logstash-1.4.2.tar.gz
RUN ln -s /opt/logstash-1.4.2 /opt/logstash
RUN rm -rf /tmp/*


ADD conf/logstash.conf /data/logstash.conf

ADD conf/01-lumberjack-input.conf /etc/logstash/conf.d/01-lumberjack-input.conf
ADD conf/02-nginx-input.conf /etc/logstash/conf.d/02-nginx-input.conf
ADD conf/10-syslog.conf /etc/logstash/conf.d/10-syslog.conf
ADD conf/29-nginx-output.conf /etc/logstash/conf.d/20-nginx-output.conf
ADD conf/30-lumberjack-output.conf /etc/logstash/conf.d/30-lumberjack-output.conf

VOLUME ["/data"]

EXPOSE 514
EXPOSE 9292

CMD /opt/logstash/bin/logstash \
    agent \
    --config /data/logstash.conf \
    -- \
    web




