# Overview
Fluent Event Integration
#
```
export FI_IDENTIFIER=fluentmock-1
export FI_EVENT_HOST=
```

# curl commands
```
curl --location --request POST http://$FI_EVENT_HOST/event/postAndVerify \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER" \
--data-raw '{
  "name": "SendOrderStatusAck",
  "entityId": "3786",
  "entityType": "ORDER"
}'

curl --location --request POST http://$FI_EVENT_HOST/event/search \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER" \
--data-raw '{
	"id": "cf486a2e-9892-11ed-9852-efd748c6a0db"
}'

curl --location --request POST http://$FI_EVENT_HOST/event/search \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER" \
--data-raw '{
        "from":"2023-01-20T07:19:10.369Z",
        "rootEntityId":"4159",
        "rootEntityType":"ORDER",
        "count":10
}'

curl --location --request POST http://$FI_EVENT_HOST/event/status \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER" \
--data-raw '{
	"id": "cf486a2e-9892-11ed-9852-efd748c6a0db"
}'


curl --location --request POST http://$FI_EVENT_HOST/event/status \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER" \
--data-raw '{
    "from":"2023-01-20T07:19:10.369Z",
    "rootEntityId":"4159",
    "rootEntityType":"ORDER",
    "count": 10
}'

 curl --location --request POST http://$FI_EVENT_HOST/events/status \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER" \
--data-raw '[
    {"id": "cf486a2e-9892-11ed-9852-efd748c6a0db"},
    {"id": "be0b1d41-9892-11ed-a1a0-c95bd0f5f7d9"}
]'

curl --location --request POST http://$FI_EVENT_HOST/events/search \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER" \
--data-raw '[
    {"id": "cf486a2e-9892-11ed-9852-efd748c6a0db"},
    {"id": "be0b1d41-9892-11ed-a1a0-c95bd0f5f7d9"}
]'

curl --location --request POST http://$FI_EVENT_HOST/events/search \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER" \
--data-raw '[
    {
        "from":"2023-01-20T07:19:10.369Z",
        "rootEntityId":"4159",
        "rootEntityType":"ORDER",
        "count":100
    },
    {"id": "cf486a2e-9892-11ed-9852-efd748c6a0db"}
]'
```