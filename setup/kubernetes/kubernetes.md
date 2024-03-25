# Running FlintX on Kubernetes
## Prerequisites
- jq (https://stedolan.github.io/jq/)
- docker (https://www.docker.com/)
- kubernetes / minikube (https://minikube.sigs.k8s.io/)
- kubectl (https://kubernetes.io/docs/reference/kubectl/)
- helm (https://helm.sh/)


## Configuration
The Kubernetes folder contains the relevant scripts and configuration files which are used for the setup of FlintX on Kubernetes:
- [_flintx-fluent-kubernetes-config.json_](flintx-fluent-kubernetes-config.json)<br>
  Defines the available configuration details as well as specific configurations for each FlintX service.
- [_kubernetes-install.sh_](kubernetes-install.sh)<br>
  Script which reads the configuration and installs the configured services.
  Example:<br>
  ```$ ./kubernetes-install.sh flintx-fluent-kubernetes-config.json [all|{{serviceName}}]```
- [_kubernetes-uninstall.sh_](kubernetes-uninstall.sh)<br>
  Script which reads the configuration and uninstalls the configured services.
  Example:<br>
  ```$ ./kubernetes-uninstall.sh flintx-fluent-kubernetes-config.json [all|{{serviceName}}]```
- [_configs_](configs) <br>
  Folder contains the Helm Config definitions for each FlintX service.
- [_secrets_](secrets) <br>
  Folder contains the Helm Secret definitions for the FlintX services.

## Minikube quickstart commands
```shell
$ minikube start
$ eval $(minikube -p minikube docker-env)

# enable add-ons
$ minikube addons enable ingress
$ minikube addons enable metrics-server
$ minikube dashboard --url &

# create the kubernetes namespace
$ kubectl create namespace flintx
$ kubectl config set-context --current --namespace=flintx

# create required clusterrole
$ kubectl create clusterrole secretview --verb=get  --resource=secret --namespace=flintx

# start minikube tunnel
$ minikube tunnel
```