#!/bin/sh

# Minkube
echo "==== Start Minikube ==========================================="
minikube start --driver=virtualbox
minikube addons enable metallb
echo "==== Done ====================================================="
echo ""

# Set env to Docker
eval $(minikube docker-env)

# Build Dokcer images
echo "==== Build Docker images ======================================"
echo "  - wordpress"
docker build -t service-wordpress ./srcs/wordpress/ >> ./docker_build.log
echo "  - mysql"
docker build -t service-mysql ./srcs/mysql/ >> ./docker_build.log
echo "  - phpmyadmin"
docker build -t service-phpmyadmin ./srcs/phpmyadmin/ >> ./docker_build.log
echo "  - nginx"
docker build -t service-nginx ./srcs/nginx/ >> ./docker_build.log
echo "  - influxdb"
docker build -t service-influxdb ./srcs/influxdb/ >> ./docker_build.log
echo "  - grafana"
docker build -t service-grafana ./srcs/grafana/ >> ./docker_build.log
echo "  - ftps"
docker build -t service-ftps ./srcs/ftps/ >> ./docker_build.log
echo "==== Done ====================================================="
echo ""

# MetalLB
echo "==== Setup MetalLB ============================================"
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/metallb-config.yaml
echo "==== Done ====================================================="
echo ""

echo "==== Create Pods =============================================="
# Apply MySQL, Phpmyadmin, InfluxDB, Grafana Wordpress and Ftps
kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/influxdb/influxdb.yaml
kubectl apply -f ./srcs/grafana/grafana.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml

# Get external ip from wordpress service;
EXTERN_IP="$(kubectl get services|grep wordpress|awk '{print $4}')";

# Apply NginX server and create index page from template
cat ./srcs/nginx/srcs/nginx-index-config-template.yaml | \
sed -e "s/FT_SITEIP/$(echo -n $EXTERN_IP)/" > ./srcs/nginx/nginx-index-config.yaml
diff ./srcs/nginx/srcs/nginx-index-config-template.yaml \
		./srcs/nginx/nginx-index-config.yaml
kubectl apply -f ./srcs/nginx/nginx-index-config.yaml
kubectl apply -f ./srcs/nginx/nginx.yaml

# Apply Ftps and create Ftps-configMap from template
cat ./srcs/ftps/srcs/ftps-config-template.yaml | \
sed -e "s/FT_SITEIP/$(echo -n $EXTERN_IP)/" > ./srcs/ftps/ftps-config.yaml
diff ./srcs/ftps/srcs/ftps-config-template.yaml \
		./srcs/ftps/ftps-config.yaml
kubectl apply -f ./srcs/ftps/ftps-config.yaml
kubectl apply -f ./srcs/ftps/ftps.yaml
echo "==== Done ====================================================="
echo ""
echo "    ✨✨ Enjoy FT🌟SERVICES ✨✨    "
echo ""
