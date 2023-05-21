#! /bin/bash

configFile=$1; shift
flintxServices=("$@")
flintxDockerNetworkName=$(jq -r '.network' ${configFile})
flintxDockerVolumeName=$(jq -r '.storage' ${configFile})

if [[ "${flintxServices[0]}" == "all" ]]; then
  flintxServices=($(jq -r '.services[] | .name' ${configFile}))
fi
for flintxService in "${flintxServices[@]}"; do
  _service() {
    echo "${flintxServiceJson}" | base64 --decode | jq -r "${1}"
  }
  echo "Uninstalling service: ${flintxService}"
  flintxServiceJson=$(jq -r --arg flintxService $flintxService '.services[] | select(.name == $flintxService) | @base64' ${configFile})
  flintxServiceName=$(_service '.name')
  flintxServiceVersion=$(_service '.version')

  if [[ $(docker ps --filter "name=${flintxServiceName}" | grep "${flintxServiceName}") ]]; then
        echo "Stopping & deleting container ${flintxServiceName}."
        stopped=$(docker stop "${flintxServiceName}")
  else
    echo "Container ${flintxServiceName} does not exist."
  fi
done

if [[ $(docker network ls | grep "${flintxDockerNetworkName}") ]]; then
  echo "Deleting network ${flintxDockerNetworkName}."
  docker network rm "${flintxDockerNetworkName}"
  echo "Deleted network ${flintxDockerNetworkName}."
else
  echo "Network ${flintxDockerNetworkName} does not exists."
fi
if [[  $(docker volume ls | grep "${flintxDockerVolumeName}") ]]; then
  echo "Deleting volume ${flintxDockerVolumeName}."
  docker volume rm "${flintxDockerVolumeName}"
  echo "Deleted volume ${flintxDockerVolumeName}."
else
  echo "Volume ${flintxDockerVolumeName} does not exists."
fi