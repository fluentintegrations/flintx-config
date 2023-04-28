# Overview
Fluent Integrations

# curl commands
```
export FI_IDENTIFIER=fluentmock-1
export FI_AUTH_HOST=127.0.0.1:8081
```

```
curl --location --request GET http://$FI_AUTH_HOST/auth \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER"

kubectl create clusterrole secretview \
--verb=get  \
--resource=secret \
--namespace=flintx

kubectl create clusterrolebinding flintx-auth-secret \
--clusterrole=secretview \
--serviceaccount=flintx:flintx-auth \
--namespace=flintx

kubectl get serviceaccounts \
--namespace=flintx

kubectl delete clusterrolebinding flintx-auth-secret
```