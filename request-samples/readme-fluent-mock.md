# Overview
Batch Integration

# curl commands
```
export FI_FLUENT_MOCK_HOST=

curl --location --request POST "http://$FI_FLUENT_MOCK_HOST/oauth/token?username=fluentmock&password=fluentmock&client_id=FLUENTMOCK&client_secret=fluentmock&grant_type=password&scope=api" \
--header 'Content-Type: application/json'

```
