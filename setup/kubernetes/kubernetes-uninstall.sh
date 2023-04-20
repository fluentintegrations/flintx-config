#! /bin/bash
configFile="kubernetes-config.json"
flintxServices=$(jq '.services' ${configFile})
flintxVersion=$(jq -r '.version' ${configFile})
flintxDockerNetworkName=$(jq -r '.namespace' ${configFile})

for service in $(echo "${flintxServices}" | jq -r '.[] | @base64'); do
    _service() {
     echo "${service}" | base64 --decode | jq -r "${1}"
    }
   flintxServiceName=$(_service '.name')
   flintxServicePort=$(_service '.port')
   flintxServiceSecrets=$(_service '.secrets')
   flintxServiceConfigs=$(_service '.configs')

    helm uninstall "${flintxServiceName}" -n "${flintxKubernetesNamespace}"

    for secret in $(echo "${flintxServiceSecrets}" | jq -r '.[] | @base64'); do
      if [ -n "${secret}" ]; then
        helm uninstall flintx-secrets -n "${flintxKubernetesNamespace}";
      fi
    done

    for config in $(echo "${flintxServiceConfigs}" | jq -r '.[] | @base64'); do
      if [ -n "${config}" ]; then
        helm uninstall flintx-configs -n "${flintxKubernetesNamespace}";
      fi
    done
done

