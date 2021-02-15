#!/bin/sh

minikube start --driver=virtualbox
			--bootstrapper=kubeadm	\
			--extra-config=kubelet.authentication-token-webhook=true \
			--extra-config=apiserver.service-node-port-range=3000-35000

minikube addons enable metallb
minikube addons enable dashboard
minikube addons enable metrics-server

eval $(minikube docker-env)

docker build -t service-mysql ./srcs/mysql/
docker build -t service-phpmyadmin ./srcs/phpmyadmin/
docker build -t service-wordpress ./srcs/wordpress/
docker build -t service-nginx ./srcs/nginx/

kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml
kubectl apply -f ./srcs/nginx/nginx.yaml

# kubectl delete -f ./srcs/phpmyadmin/phpmyadmin.yaml;kubectl delete -f ./srcs/mysql/mysql.yaml
# kubectl port-forward phpmyadmin-7cf4c5c785-mz25w 5000:80 -n default
