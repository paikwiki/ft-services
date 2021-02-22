#!/bin/sh

# Minkube
minikube start --driver=virtualbox \
			--extra-config=kubelet.authentication-token-webhook=true

# Set Minikue addons
minikube addons enable metallb

# MetalLB
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/metallb_config.yaml

# Set env to Docker
eval $(minikube docker-env)

# Build Dokcer images
docker build -t service-wordpress ./srcs/wordpress/
docker build -t service-mysql ./srcs/mysql/
docker build -t service-phpmyadmin ./srcs/phpmyadmin/
docker build -t service-nginx ./srcs/nginx/
docker build -t service-influxdb ./srcs/influxdb/
docker build -t service-grafana ./srcs/grafana/
docker build -t service-ftps ./srcs/ftps/

# Apply all yaml files
kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/influxdb/influxdb.yaml
kubectl apply -f ./srcs/grafana/grafana.yaml
kubectl apply -f ./srcs/ftps/ftps.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml
kubectl apply -f ./srcs/wordpress/wordpress-config.yaml
cat ./srcs/nginx/srcs/index-template.html | \
sed -e "s/FT_SITEIP/$(kubectl get services|grep wordpress|awk '{print $4}')/" \
> ./srcs/nginx/srcs/index.html
cat ./srcs/nginx/srcs/index.html
kubectl apply -f ./srcs/nginx/nginx.yaml
