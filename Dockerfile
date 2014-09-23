#
#
#   Dockerfile Logstash - ipedrazas@gmail.com
#

FROM dockerfile/java:oracle-java7

MAINTAINER Ivan Pedrazas<ipedrazas@gmail.com>

RUN cd /opt && wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz && tar zxf logstash-1.4.2.tar.gz && rm logstash-1.4.2.tar.gz
RUN ln -s /opt/logstash-1.4.2 /opt/logstash
RUN rm -rf /tmp/*
RUN mv /opt/logstash/vendor/kibana/app/dashboards/logstash.json /opt/logstash/vendor/kibana/app/dashboards/default.json

ADD conf/nginx.grok /opt/logstash/patterns/nginx

#ADD conf/logstash.conf /data/logstash.conf


ADD conf/11-nginx.conf /etc/logstash/conf.d/11-nginx.conf

VOLUME ["/data"]

EXPOSE 514
EXPOSE 9292

CMD /opt/logstash/bin/logstash \
    agent \
    --config /data/logstash.conf \
    -- web




# /opt/logstash/bin/logstash -v agent --config /data/logstash.conf  -- web