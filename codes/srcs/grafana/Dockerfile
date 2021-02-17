FROM alpine:3.11.6

RUN apk update
RUN apk add openrc
RUN apk add libc6-compat --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main
RUN apk add grafana --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/
# RUN apk add grafana=7.3.6-r0 --repository=https://dl-cdn.alpinelinux.org/alpine/latest-stable/community/

COPY ./srcs/* /tmp/
COPY ./srcs/dashboards/ /tmp/dashboards/
RUN chmod 777 -R /tmp/*

RUN mv /tmp/dashboards/* /usr/share/grafana/public/dashboards/
RUN mv /tmp/influxdb_info.yaml /usr/share/grafana/conf/provisioning/datasources/
RUN mv /tmp/dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/

EXPOSE 3000

ENTRYPOINT ["/tmp/init.sh"]

