# Overview
Fluent Integrations

# pre-requisites
```
kubectl create clusterrole secretview \
--verb=get  \
--resource=secret \
--namespace=flintx
```

# curl commands
```
export FI_IDENTIFIER=fluentmock-1
export FI_AUTH_HOST=127.0.0.1:8081
```

```
curl --location --request GET http://$FI_AUTH_HOST/auth \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER"
```