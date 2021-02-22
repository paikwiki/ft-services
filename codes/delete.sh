#!/bin/sh

minikube stop;
minikube delete;
rm -f ./srcs/nginx/nginx-index-config.yaml
