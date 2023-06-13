# Overview
Fluent Inventory Integration

# curl commands
```
export FI_INVENTORY_HOST=flintx-fluent-inventory.io
export FI_INVENTORY_HOST=127.0.0.1:8085

# (fluentmock-1)
export FI_APIKEY=eyJhY2NvdW50SWQiOiJmbHVlbnRtb2NrIiwicmV0YWlsZXJJZCI6IjEiLCJjcmVhdGVkT24iOiIyMDIzLTAzLTIwVDAwOjAwOjAwIn0=.e7rxEJLw3fAvmLk8J1CA5JCHtSNgcTLSmtqKz96S1+SzMY9ZAubgR33joqDq6rXQRatCjNSXec5kRDlx1GSeDdqbC8YTLPguVD0NWVrWv6Yi3IzM4dZ7ha+FSeKnP9flAUWTjviIY9yo+0oFVVc8YdqXMAUgL/fNuPsFyxrRR0JQydFcC8W76hmHG+WgIkjomZI7OOj0UtZUK443covClybLVIG8cM8WJKhOGCCoeAFEVgqDrd2EppE+SOf3tqaRUCB26UPJZFR5vc6+pDxtJ7PU2yzqyYYpDoiePjqdZJu+FEhiMx9sz/WL+9QiE1GsvsTe7t9r7g454WZPZB/CrQ==

curl --location --request POST http://$FI_INVENTORY_HOST/inventory/load \
--header 'Content-Type: multipart/form-data' \
--header "apiKey:$FI_APIKEY" \
--header 'splitCount: 50' \
--form 'file=@"./test-files/inventory.csv"'

curl --location --request POST http://$FI_INVENTORY_HOST/inventory/load \
--header 'Content-Type: multipart/form-data' \
--header "apiKey:$FI_APIKEY" \
--header 'splitCount: 50' \
--form 'file=@"./test-files/inventory.json"'

curl --location --request POST http://$FI_INVENTORY_HOST/inventory/event \
--header 'Content-Type: application/json' \
--header "apiKey:$FI_APIKEY" \
--data-raw '{"deltas": [{ "productRef": "FLINTX", "locationRef": "LOC_FLINTX","qty": 200, "type": "DELTA", "deltaId":"123"}]}'
```