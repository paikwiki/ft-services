#!/bin/sh

# Minkube
echo "==== Start Minikube ==========================================="
minikube start --driver=virtualbox \
			--extra-config=kubelet.authentication-token-webhook=true
minikube addons enable metallb
echo "==== Done =====================================================\n"

# Set env to Docker
eval $(minikube docker-env)


# Build Dokcer images
echo "==== Build Docker images ======================================"
docker build -t service-wordpress ./srcs/wordpress/
docker build -t service-mysql ./srcs/mysql/
docker build -t service-phpmyadmin ./srcs/phpmyadmin/
docker build -t service-nginx ./srcs/nginx/
docker build -t service-influxdb ./srcs/influxdb/
docker build -t service-grafana ./srcs/grafana/
docker build -t service-ftps ./srcs/ftps/
echo "==== Done =====================================================\n"

# MetalLB
echo "==== Create Pods =============================================="
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
MINIKUBE_IP=$(minikube ip)
sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" yaml/metallb-config_format.yaml > ./yaml/metallb-config.yaml
kubectl apply -f yaml/metallb-config.yaml >> $LOG_PATH
echo "==== Done ====================================================="
echo ""

Apply MySQL, Phpmyadmin, InfluxDB, Grafana Wordpress and Ftps
kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/influxdb/influxdb.yaml
kubectl apply -f ./srcs/grafana/grafana.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml
kubectl apply -f ./srcs/ftps/ftps.yaml

# Apply NginX server and create index page from template
# SITEIP="$(kubectl get services|grep wordpress|awk '{print $4}')";
# cat ./srcs/nginx/nginx-index-config-template.yaml | \
# sed -e "s/FT_SITEIP/$(echo -n $SITEIP)/" > ./srcs/nginx/nginx-index-config.yaml
# diff ./srcs/nginx/nginx-index-config-template.yaml \
# 		./srcs/nginx/nginx-index-config.yaml
kubectl apply -f ./srcs/nginx/nginx-index-config.yaml
kubectl apply -f ./srcs/nginx/nginx.yaml
echo "==== Done ====================================================="
echo ""
echo "    ✨✨ Enjoy FT🌟SERVICES ✨✨    "
echo ""
