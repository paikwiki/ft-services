FROM alpine:3.12.0
#FROM alpine:3.11.6
#FROM alpine

WORKDIR /usr/share/grafana

RUN apk update
RUN apk add grafana \
	--repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/

#RUN apk add grafana \
#	--repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/
#	 --repository http://dl-2.alpinelinux.org/alpine/edge/community/
#    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/

#COPY srcs/datasources.yml /usr/share/grafana/conf/provisioning/datasources/
#COPY srcs/dashboards.yml /usr/share/grafana/conf/provisioning/dashboards/
COPY dashboards/ /usr/share/grafana/public/dashboards/

EXPOSE 3000

ENTRYPOINT ["/usr/sbin/grafana-server", "web"]
