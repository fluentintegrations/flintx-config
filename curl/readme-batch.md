# Overview
Batch Integration

# curl commands
```
export FI_BATCH_HOST=

# (fluentmock-1)
export FI_APIKEY=eyJhY2NvdW50SWQiOiJmbHVlbnRtb2NrIiwicmV0YWlsZXJJZCI6IjEiLCJjcmVhdGVkT24iOiIyMDIzLTAzLTIwVDAwOjAwOjAwIn0=.e7rxEJLw3fAvmLk8J1CA5JCHtSNgcTLSmtqKz96S1+SzMY9ZAubgR33joqDq6rXQRatCjNSXec5kRDlx1GSeDdqbC8YTLPguVD0NWVrWv6Yi3IzM4dZ7ha+FSeKnP9flAUWTjviIY9yo+0oFVVc8YdqXMAUgL/fNuPsFyxrRR0JQydFcC8W76hmHG+WgIkjomZI7OOj0UtZUK443covClybLVIG8cM8WJKhOGCCoeAFEVgqDrd2EppE+SOf3tqaRUCB26UPJZFR5vc6+pDxtJ7PU2yzqyYYpDoiePjqdZJu+FEhiMx9sz/WL+9QiE1GsvsTe7t9r7g454WZPZB/CrQ==

curl --location --request POST http://$FI_BATCH_HOST/batch \
--header 'Content-Type: application/json' \
--header "apiKey:$FI_APIKEY" \
--data-raw '{
	"queryFile":"virtualPositions.graphql",
	"edgeTypeName": "virtualPositionEdge",
	"outputFile": "out.csv",
	"outputFormat": "csv",
	"splitCount": 100,
	"variables": {"ref":"%LOC_FLINTX%", "updatedFrom": "2023-01-01T00:00:00.000", "catalogueRef":"BASE:1"}
}'

curl --location --request POST http://$FI_BATCH_HOST/batch \
--header 'Content-Type: application/json' \
--header "apiKey:$FI_APIKEY" \
--data-raw '{
	"queryFile":"virtualPositions.graphql",
	"edgeTypeName": "virtualPositionEdge",
	"outputFile": "out.json",
	"outputFormat": "json",
	"splitCount": 100,
	"variables": {"ref":"%LOC_BRIS%", "updatedFrom": "2023-01-01T00:58:41.913", "catalogueRef":"BASE:1"}
}'
```
