#! /bin/bash

configFile=$1; shift
flintxServices=("$@")
flintxNamespace=$(jq -r '.namespace' ${configFile})
if [[ "${flintxServices[0]}" == "all" ]]; then
  flintxServices=($(jq -r '.services[] | .name' ${configFile}))
fi

for flintxService in "${flintxServices[@]}"; do
  _service() {
    echo "${flintxServiceJson}" | base64 --decode | jq -r "${1}"
  }
  echo "Configuring service: ${flintxService}"
  flintxServiceJson=$(jq -r --arg flintxService $flintxService '.services[] | select(.name == $flintxService) | @base64' ${configFile})
  flintxServiceName=$(_service '.name')
  flintxServiceVersion=$(_service '.version')
  flintxServicePort=$(_service '.port')
  flintxServiceSecrets=$(_service '.secrets')
  flintxServiceConfigs=$(_service '.configs')
  
  # preload images
  # docker pull fluentintegrations/${flintxServiceName}:${flintxServiceVersion} --platform linux/amd64
  # docker pull fluentintegrations/${flintxServiceName}:${flintxServiceVersion}-arm64

  helm install \
  --set app.name="${flintxServiceName}" \
  --set app.version="${flintxServiceVersion}" \
  --set app.image="fluentintegrations/${flintxServiceName}:${flintxServiceVersion}" \
  "${flintxServiceName}" "./services/${flintxServiceName}" -n "${flintxNamespace}"
done

if [[ "${flintxServices[0]}" == "all" ]]; then
  helm install flintx-configs ./config -n "${flintxNamespace}";
  helm install flintx-secrets ./secret -n "${flintxNamespace}";
fi

