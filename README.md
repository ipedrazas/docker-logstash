# Logstash


sudo mkdir -p /data/logstash/pki/tls/certs
sudo mkdir -p /data/logstash/pki/tls/private
cd /data/logstash/pki; \
    sudo openssl req -x509 -batch -nodes -days 3650 -newkey rsa:2048 \
    -keyout logstash-forwarder.key \
    -out logstash-forwarder.crt




# docker run -d -p 9292:9292 --link es:es -v /var/log:/var/log -v /data/logstash:/data ipedrazas/logstash

docker run -it --rm -link es:es -v /data/logstash:/data -v /var/log:/var/log ipedrazas/logstash bash

/opt/logstash/bin/logstash agent --configtest --config /data/logstash.conf -e "input { stdin{} } output { elasticsearch { host => es } }"

/opt/logstash/bin/logstash agent --config /data/logstash.conf -e "input { stdin{} } output { stdout { codec => rubydebug }  elasticsearch {    host => es}}"