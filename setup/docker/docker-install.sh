#! /bin/bash

configFile=$1; shift
flintxServices=$(jq '.services' ${configFile})
flintxVersion=$(jq -r '.version' ${configFile})
flintxDockerNetworkName=$(jq -r '.network' ${configFile})
flintxDockerVolumeName=$(jq -r '.storage' ${configFile})

if [[ ! $(docker network ls | grep "${flintxDockerNetworkName}") ]]; then
  echo "Creating network ${flintxDockerNetworkName}."
  docker network create --subnet=172.21.0.0/16 "${flintxDockerNetworkName}"
  echo "Created network ${flintxDockerNetworkName}."
else
  echo "Network ${flintxDockerNetworkName} already exists."
fi
if [[ ! $(docker volume ls | grep "${flintxDockerVolumeName}") ]]; then
  echo "Creating volume ${flintxDockerVolumeName}."
  docker volume create "${flintxDockerVolumeName}"
  echo "Created volume ${flintxDockerVolumeName}."
else
  echo "Volume ${flintxDockerVolumeName} already exists."
fi

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

  if [[ ! $(docker ps --filter "name=${flintxServiceName}" | grep "${flintxServiceName}") ]]; then
    echo "Starting container ${flintxServiceName}."
  else
    echo "Restarting container ${flintxServiceName}."
    stopped=$(docker stop "${flintxServiceName}")
  fi
  containerId=$(docker run -d --rm -p ${flintxServicePort}:${flintxServicePort} --ip=${flintxServiceIP} \
    --net ${flintxDockerNetworkName} --name=${flintxServiceName} \
    ${flintxServiceParameters} \
    fluentintegrations/${flintxServiceName}:${flintxVersion})
  echo "Started container ${flintxServiceName} id:${containerId}"

  for secret in $(echo "${flintxServiceSecrets}" | jq -r '.[] | @base64'); do
    secretFile=$(echo "${secret}" | base64 --decode)
    docker cp secrets/"${secretFile}" "${flintxServiceName}":/config
  done
  for config in $(echo "${flintxServiceConfigs}" | jq -r '.[] | @base64'); do
    configFile=$(echo "${config}" | base64 --decode)
    docker cp configs/"${configFile}" "${flintxServiceName}":/config
  done
done
