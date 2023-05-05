# Overview
Fluent Product Integration

# curl commands
```
export FI_PRODUCT_HOST=127.0.0.1:8086

# (fluentmock-1)
export FI_APIKEY=eyJhY2NvdW50SWQiOiJmbHVlbnRtb2NrIiwicmV0YWlsZXJJZCI6IjEiLCJjcmVhdGVkT24iOiIyMDIzLTAzLTIwVDAwOjAwOjAwIn0=.e7rxEJLw3fAvmLk8J1CA5JCHtSNgcTLSmtqKz96S1+SzMY9ZAubgR33joqDq6rXQRatCjNSXec5kRDlx1GSeDdqbC8YTLPguVD0NWVrWv6Yi3IzM4dZ7ha+FSeKnP9flAUWTjviIY9yo+0oFVVc8YdqXMAUgL/fNuPsFyxrRR0JQydFcC8W76hmHG+WgIkjomZI7OOj0UtZUK443covClybLVIG8cM8WJKhOGCCoeAFEVgqDrd2EppE+SOf3tqaRUCB26UPJZFR5vc6+pDxtJ7PU2yzqyYYpDoiePjqdZJu+FEhiMx9sz/WL+9QiE1GsvsTe7t9r7g454WZPZB/CrQ==

curl --location --request POST http://$FI_PRODUCT_HOST/product/load \
--header 'Content-Type: application/json' \
--header "apiKey:$FI_APIKEY" \
--data-raw '{"ref":"FLINTX","type":"VARIANT","status":"ACTIVE","gtin":"FLINTX","name":"FlintX","summary":"The Swiss Army Knife for Fluent Integrations","standardProductRef":"FLINTX_SPRD","attributes":[{"name":"imageUrl","type":"STRING","value":""}],"categoryRefs":["FLINTX"],"prices":[{"type":"TYPE","currency":"AUD","value":100.0}],"taxType":{"country":"Australia","group":"GROUP","tariff":"TARIFF"}}'

curl --location --request POST http://$FI_PRODUCT_HOST/product/load \
--header 'Content-Type: application/json' \
--header "apiKey:$FI_APIKEY" \
--data-raw '{"gtin":"B125AE020","name":"New York Breakfast Teabag","ref":"B125AE020","standardProductRef":"B125AE020_SPRD","status":"ACTIVE","summary":"A pancake-inspired tea made with full-bodied black tea, maple syrup flavours and cinnamon.","type":"VARIANT"}'

curl --location --request POST http://$FI_PRODUCT_HOST/products/load \
--header 'Content-Type: multipart/form-data' \
--header "apiKey:$FI_APIKEY" \
--header 'splitCount: 1' \
--form 'file=@"./test-files/products.csv"'

curl --location --request POST http://$FI_PRODUCT_HOST/category/load \
--header 'Content-Type: application/json' \
--header "apiKey:$FI_APIKEY" \
--data-raw '{"ref":"FLINTX","name":"FlintX","status":"ACTIVE","type":"DEFAULT"}'

curl --location --request POST http://$FI_PRODUCT_HOST/categories/load \
--header 'Content-Type: multipart/form-data' \
--header "apiKey:$FI_APIKEY" \
--header 'splitCount: 1' \
--form 'file=@"./test-files/categories.csv"'
```