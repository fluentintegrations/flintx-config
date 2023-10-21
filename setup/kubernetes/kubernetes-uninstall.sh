#! /bin/bash

configFile=$1; shift
flintxServices=("$@")
flintxNamespace=$(jq -r '.namespace' ${configFile})

undeployAll=false
if [[ "${flintxServices[0]}" == "all" ]]; then
  undeployAll=true
  flintxServices=($(jq -r '.services[] | .name' ${configFile}))
fi

for flintxService in "${flintxServices[@]}"; do
  _service() {
    echo "${flintxServiceJson}" | base64 --decode | jq -r "${1}"
  }
  flintxServiceJson=$(jq -r --arg flintxService $flintxService '.services[] | select(.name == $flintxService) | @base64' ${configFile})
  flintxServiceName=$(_service '.name')
  flintxServiceSecrets=$(_service '.secrets')
  flintxServiceConfigs=$(_service '.configs')

  helm uninstall "${flintxServiceName}" -n "${flintxNamespace}"
done

if $undeployAll; then
  helm uninstall flintx-secrets -n "${flintxNamespace}";
  helm uninstall flintx-configs -n "${flintxNamespace}";
  helm uninstall flintx-platform -n "${flintxNamespace}";
fi
