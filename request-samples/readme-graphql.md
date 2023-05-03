# Overview
GraphQL Integrations

# curl commands
```

export FI_IDENTIFIER=fluentmock-1
export FI_GRAPHQL_HOST=127.0.0.1:8083

curl --location --request POST http://$FI_GRAPHQL_HOST/graphql/mutation \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER" \
--data-raw '{
	"query":"mutation createCustomer($input: CreateCustomerInput!) { createCustomer(input:$input){ id } }",
	"variables": {"input": {"title": "Mr", "firstName": "Flint", "lastName": "X", "primaryEmail": "hello@flintx.com", "primaryPhone": "+61123456789", "username": "flintx:1", "timezone": "Australia/Melbourne", "promotionOptIn": false, "retailer": {"id": 1} }}
}'

curl --location --request POST "http://$FI_GRAPHQL_HOST/graphql/query" \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER" \
--data-raw '{
	"query":"query orderByRef($orderRef: String!) {order(ref: $orderRef) { id ref status } }",
	"variables": {"orderRef":"HD_387_56"}
}'

curl --location --request POST "http://$FI_GRAPHQL_HOST/graphql/query" \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER" \
--data-raw '{
	"query": "query customerByRef($customerRef: String!) { customer(ref: $customerRef) { id ref title firstName lastName username primaryEmail } }",
	"variables": {"customerRef":"flintx:1"}
}'
```