FROM		alpine:3.12.1

WORKDIR		/usr/share/grafana

RUN			apk update
RUN			apk add grafana \
				--repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/

COPY		dashboards/ /usr/share/grafana/public/dashboards/

EXPOSE		3000

ENTRYPOINT	["/usr/sbin/grafana-server", "web"]
