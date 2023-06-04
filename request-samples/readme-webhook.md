# Overview
Webhook Integrations

# curl commands
```
export FI_WEBHOOK_HOST=127.0.0.1:8084
export FI_WEBHOOK_HOST=flintx-fluent-webhook.io

OK:
curl --location --request POST http://$FI_WEBHOOK_HOST/webhook \
--header 'Content-Type: application/json' \
--header 'flex.signature: J1WcIF5nq5teN9Ag3gZZ3yNDUr/igyF+FjLUWI8RI7XGrOkgObj1W0nyzuFVvxJO+cCEqDU1ayMKT+snGH8+HkBFG2LNZPYmFhxePSbQ0enz9Pa8Gij0EnF+KmzUJwGSkqIgLjUGrnHuKZhmPbM8D5kaeUuJKwDma+pmE8/oy6o=' \
--header 'fluent-signature: gi2n8hUILq36XEOSwQuaMhNUEg2xAmmlgpmQhIUXqem4ykUYmndjyyVQJJdvsZe10w6gGHgPDS5wb9ihpCGug+pC1CXUjoo81/mHnBwnb+afYI1g4nyCMgMG7F2OC4uhIqM/AXbGQKMF1MPsJ/AygowKGFKZRx57iFmM5DzvdWI=' \
--data-raw '{"id":"5f7fa2bd-39b2-4105-98f4-29b6ca3afc98","name":"OrderStatus","accountId":"HOLGER","retailerId":"1","entityId":"3786","entityRef":"HD_387_56","entityType":"ORDER","entityStatus":"COMPLETE","type":"NORMAL","attributes":{},"meta":{"mode":"SYNC","simulation":false,"models":[]},"trailLogs":[],"errorLogs":[],"rootEntityId":"3786","rootEntityType":"ORDER","rootEntityRef":"HD_387_56"}'

FAIL:
curl --location --request POST http://$FI_WEBHOOK_HOST/webhook \
--header 'Content-Type: application/json' \
--header 'flex.signature: J1WcIF5nq5teN9Ag3gZZ3yNDUr/igyF+FjLUWI8RI7XGrOkgObj1W0nyzuFVvxJO+cCEqDU1ayMKT+snGH8+HkBFG2LNZPYmFhxePSbQ0enz9Pa8Gij0EnF+KmzUJwGSkqIgLjUGrnHuKZhmPbM8D5kaeUuJKwDma+pmE8/oy6o=' \
--header 'fluent-signature: gi2n8hUILq36XEOSwQuaMhNUEg2xAmmlgpmQhIUXqem4ykUYmndjyyVQJJdvsZe10w6gGHgPDS5wb9ihpCGug+pC1CXUjoo81/mHnBwnb+afYI1g4nyCMgMG7F2OC4uhIqM/AXbGQKMF1MPsJ/AygowKGFKZRx57iFmM5DzvdWI=' \
--data-raw '{"id":"","name":"OrderStatus","accountId":"HOLGER","retailerId":"1","entityId":"3786","entityRef":"HD_387_56","entityType":"ORDER","entityStatus":"COMPLETE","type":"NORMAL","attributes":{},"meta":{"mode":"SYNC","simulation":false,"models":[]},"trailLogs":[],"errorLogs":[],"rootEntityId":"3786","rootEntityType":"ORDER","rootEntityRef":"HD_387_56"}'
```