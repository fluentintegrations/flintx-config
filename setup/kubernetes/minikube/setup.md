# minikube
`minikube start`

`minikube addons enable metrics-server`
`minikube addons enable registry`

`minikube dashboard --url &`

`eval $(minikube -p minikube docker-env)`

`kubectl config set-context --current --namespace=flintx`