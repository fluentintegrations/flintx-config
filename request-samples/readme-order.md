# Overview
Fluent Order Integration

# curl commands
```
export FI_ORDER_HOST=127.0.0.1:8087
export FI_ORDER_HOST=flintx-fluent-order.io

# (fluentmock-1)
export FI_APIKEY=eyJhY2NvdW50SWQiOiJmbHVlbnRtb2NrIiwicmV0YWlsZXJJZCI6IjEiLCJjcmVhdGVkT24iOiIyMDIzLTAzLTIwVDAwOjAwOjAwIn0=.e7rxEJLw3fAvmLk8J1CA5JCHtSNgcTLSmtqKz96S1+SzMY9ZAubgR33joqDq6rXQRatCjNSXec5kRDlx1GSeDdqbC8YTLPguVD0NWVrWv6Yi3IzM4dZ7ha+FSeKnP9flAUWTjviIY9yo+0oFVVc8YdqXMAUgL/fNuPsFyxrRR0JQydFcC8W76hmHG+WgIkjomZI7OOj0UtZUK443covClybLVIG8cM8WJKhOGCCoeAFEVgqDrd2EppE+SOf3tqaRUCB26UPJZFR5vc6+pDxtJ7PU2yzqyYYpDoiePjqdZJu+FEhiMx9sz/WL+9QiE1GsvsTe7t9r7g454WZPZB/CrQ==

curl --location --request POST http://$FI_ORDER_HOST/order/create \
--header 'Content-Type: application/json' \
--header "apiKey:$FI_APIKEY" \
--data-raw '{
  "ref": "HD_987_610",
  "type": "HD",
  "items": [
    {
      "ref": "FLINTX",
      "productRef": "FLINTX",
      "quantity":1
    }
  ],
  "deliveryType": "STANDARD",
  "deliveryAddressName": "Flint X",
  "deliveryAddressCompanyName": "",
  "deliveryAddressStreet": "99 FlintX Street",
  "deliveryAddressCity": "Melbourne",
  "deliveryAddressState": "VIC",
  "deliveryAddressPostcode": "3000",
  "deliveryAddressCountry": "Australia",
  "deliveryAddressLongitude": 151.2093648,
  "deliveryAddressLatitude": -33.8848268,
  "shippingFee": 1.0,
  "totalPrice": 10.0,
  "totalTaxPrice": 1.0,
  "customer": {
    "ref": "flintx:1",
    "title": "Mr",
    "firstName": "Flint",
    "lastName": "X",
    "username": "flintx:1",
    "primaryEmail": "hello@flintx.com",
    "primaryPhone": "+61123456789"
  }
}'

curl --location --request POST http://$FI_ORDER_HOST/order/webhook \
--header 'Content-Type: application/json' \
--header "identifier: $FI_IDENTIFIER" \
--data-raw '{"id":"5f7fa2bd-39b2-4105-98f4-29b6ca3afc98","name":"OrderStatus","accountId":"FLINTX","retailerId":"1","entityId":"1`","entityRef":"FLINTX_1","entityType":"ORDER","entityStatus":"COMPLETE","type":"NORMAL","attributes":{},"meta":{"mode":"SYNC","simulation":false,"models":[]},"trailLogs":[],"errorLogs":[],"rootEntityId":"1","rootEntityType":"ORDER","rootEntityRef":"FLINTX_1"}'
```