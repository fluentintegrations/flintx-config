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
  flintxServiceJson=$(jq -r --arg flintxService $flintxService '.services[] | select(.name == $flintxService) | @base64' ${configFile})
  flintxServiceName=$(_service '.name')
  flintxServiceSecrets=$(_service '.secrets')
  flintxServiceConfigs=$(_service '.configs')

  helm uninstall "${flintxServiceName}" -n "${flintxNamespace}"

  for secret in $(echo "${flintxServiceSecrets}" | jq -r '.[] | @base64'); do
    if [ -n "${secret}" ]; then
      helm uninstall flintx-secrets -n "${flintxNamespace}";
    fi
  done

  for config in $(echo "${flintxServiceConfigs}" | jq -r '.[] | @base64'); do
    if [ -n "${config}" ]; then
      helm uninstall flintx-configs -n "${flintxNamespace}";
    fi
  done
done

