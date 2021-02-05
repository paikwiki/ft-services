#!/bin/sh

# kubectl proxy &

docker build -t service-mysql ./srcs/mysql/
# docker build -t service-phpmyadmin ./srcs/phpmyadmin/

kubectl apply -f ./srcs/mysql/mysql.yaml
# kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml

# kubectl delete -f ./srcs/phpmyadmin/phpmyadmin.yaml;kubectl delete -f ./srcs/mysql/mysql.yaml
