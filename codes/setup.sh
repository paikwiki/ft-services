#!/bin/sh

minikube start --driver=virtualbox \
			--extra-config=kubelet.authentication-token-webhook=true \
			--extra-config=apiserver.service-node-port-range=3000-35000

minikube addons enable metallb

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/metallb_config.yaml

eval $(minikube docker-env)

docker build -t service-wordpress ./srcs/wordpress/
docker build -t service-mysql ./srcs/mysql/
docker build -t service-phpmyadmin ./srcs/phpmyadmin/
docker build -t service-nginx ./srcs/nginx/
docker build -t service-influxdb ./srcs/influxdb/
docker build -t service-grafana ./srcs/grafana/
# docker build -t service-telegraf ./srcs/telegraf/
docker build -t service-ftps ./srcs/ftps/

kubectl apply -f ./srcs/nginx/nginx.yaml
extern_ip="$(kubectl get services|grep nginx|awk '{print $4}')"
kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/influxdb/influxdb.yaml
# kubectl apply -f ./srcs/influxdb/influxdb_conf.yaml
kubectl apply -f ./srcs/grafana/grafana.yaml
# kubectl apply -f ./srcs/telegraf/telegraf.yaml
kubectl apply -f ./srcs/ftps/ftps.yaml

# cat ./srcs/wordpress/wordpress-config-template.yaml | \
# sed -e "s/FT_SITEURL/$(echo -n $extern_ip):5050/" > ./srcs/wordpress/wordpress-config.yaml

kubectl apply -f ./srcs/wordpress/wordpress.yaml
kubectl apply -f ./srcs/wordpress/wordpress-config.yaml

# mk stop; . delete.sh ; mk delete ; . setup.sh

echo -en "\a"
sleep 1
echo -en "\a"
sleep 1
echo -en "\a"
sleep 1
echo -en "\a"
sleep 1
echo -en "\a"
sleep 1
echo -en "\a"
sleep 1
echo -en "\a"
