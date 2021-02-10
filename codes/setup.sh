#!/bin/sh

minikube start --driver=virtualbox

eval $(minikube docker-env)

docker build -t service-mysql ./srcs/mysql/
docker build -t service-phpmyadmin ./srcs/phpmyadmin/
docker build -t service-wordpress ./srcs/wordpress/

kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml

# kubectl delete -f ./srcs/phpmyadmin/phpmyadmin.yaml;kubectl delete -f ./srcs/mysql/mysql.yaml
# kubectl port-forward phpmyadmin-7cf4c5c785-mz25w 5000:80 -n default
