#! /bin/bash

configFile=$1; shift
flintxServices=("$@")
flintxNamespace=$(jq -r '.namespace' ${configFile})

deployAll=false
if [[ "${flintxServices[0]}" == "all" ]]; then
  deployAll=true
  flintxServices=($(jq -r '.services[] | .name' ${configFile}))
fi

for flintxService in "${flintxServices[@]}"; do
  _service() {
    echo "${flintxServiceJson}" | base64 --decode | jq -r "${1}"
  }
  flintxServiceJson=$(jq -r --arg flintxService $flintxService '.services[] | select(.name == $flintxService) | @base64' ${configFile})
  flintxServiceName=$(_service '.name')

  flintxServiceMappings=$(_service '.mappings')
  pod=$(kubectl get pods -l app.kubernetes.io/name=${flintxServiceName} -o jsonpath='{.items[0].metadata.name}' -n "${flintxNamespace}")
  for flintxServiceMapping in $(echo "${flintxServiceMappings}" | jq -r '.[] | @base64'); do
    flintxServiceMappingFile=$(echo "${flintxServiceMapping}" | base64 --decode)
    echo "Uploading mapping ${flintxServiceMappingFile} for service ${flintxNamespace}:${flintxServiceName} using pod ${pod}"
    cat ../../mapping/${flintxServiceMappingFile} | kubectl exec -i -n ${flintxNamespace} ${pod} "--" sh -c "cat > /work/${flintxServiceMappingFile}"
  done
done