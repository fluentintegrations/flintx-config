# Overview

# pre-requisites

```
kubectl create clusterrole secretview \
--verb=get  \
--resource=secret \
--namespace=flintx
```

```
minikube start
minikube service list -n flintx

minikube addons enable metrics-server     
minikube addons enable ingress

minikube dashboard --url &   
minikube tunnel
```