# Logstash

There are many logstash docker images out there, but I struggled a bit to configure them the way I want it so... YADi! (yet-another-docker-image).



Run logstash as a service:

    docker run -d -p 9292:9292 --link es:es -v /var/log:/var/log -v /data/logstash:/data ipedrazas/logstash

If you need to get into teh box to debug or just to see how things are:
    docker run -it --rm --link es:es -v /data/logstash:/data -v /var/log:/var/log ipedrazas/logstash bash

To validate that your setup is correct, get into a logstash container and execute the following:
    /opt/logstash/bin/logstash agent --config /data/logstash.conf -e "input { stdin{} } output { elasticsearch {    host => es}}"

Whatever you type, you should see it in your [Kibana dashboard](http://localhost:9292)


## Certificates

IF you are planning to access your logstash server remotely you will need to create your certificates. By doing this in your host, you should have your certificates generated. Then, you just have to copy them to your clients.

    sudo mkdir -p /data/logstash/pki/tls/certs
    sudo mkdir -p /data/logstash/pki/tls/private
    cd /data/logstash/pki; \
        sudo openssl req -x509 -batch -nodes -days 3650 -newkey rsa:2048 \
        -keyout logstash-forwarder.key \
        -out logstash-forwarder.crt

