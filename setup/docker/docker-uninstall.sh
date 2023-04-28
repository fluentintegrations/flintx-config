#! /bin/bash

configFile=$1; shift

flintxServices=$(jq '.services' ${configFile})
flintxVersion=$(jq -r '.version' ${configFile})
flintxDockerNetworkName=$(jq -r '.network' ${configFile})
flintxDockerVolumeName=$(jq -r '.storage' ${configFile})

for service in $(echo "${flintxServices}" | jq -r '.[] | @base64'); do
  _service() {
    echo "${service}" | base64 --decode | jq -r "${1}"
  }
  flintxServiceName=$(_service '.name')
  flintxServicePort=$(_service '.port')
  flintxServiceIP=$(_service '.ip')
  flintxServiceParameters=$(_service '.parameters[]')
  flintxServiceSecrets=$(_service '.secrets')
  flintxServiceConfigs=$(_service '.configs')

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