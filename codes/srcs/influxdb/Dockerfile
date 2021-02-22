FROM		alpine:3.12.1

RUN			apk update
RUN			apk add influxdb curl jq
RUN			apk add telegraf \
				--repository http://dl-2.alpinelinux.org/alpine/edge/community/
ENV			API_URL=https://kubernetes

COPY		setup.sh /tmp/

EXPOSE		8086

ENTRYPOINT	["/tmp/setup.sh"]
