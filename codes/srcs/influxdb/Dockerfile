FROM		alpine:3.12.1

RUN			apk update
RUN			apk add influxdb --no-cache --quiet

RUN			mkdir -p /etc/influxdb
RUN			mkdir -p /var/lib/influxdb

EXPOSE		8086

ENTRYPOINT	["/usr/sbin/influxd"]
