#! /bin/bash

configFile=$1; shift
flintxServices=("$@")
flintxDockerNetworkName=$(jq -r '.network' ${configFile})
flintxDockerVolumeName=$(jq -r '.storage' ${configFile})
flintxDockerPlatform=$(jq -r '.platform' ${configFile})

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
    echo "docker run -d --rm  -p ${flintxServicePort}:${flintxServicePort} --ip=${flintxServiceIP} --net ${flintxDockerNetworkName}  --name=${flintxServiceName} --platform ${flintxDockerPlatform} ${flintxServiceParameters} fluentintegrations/${flintxServiceName}:${flintxServiceVersion}"
     containerId=$(docker run -d --rm \
     -p ${flintxServicePort}:${flintxServicePort} \
     --ip=${flintxServiceIP} \
     --net ${flintxDockerNetworkName} \
     --name=${flintxServiceName} \
     --platform ${flintxDockerPlatform} \
     ${flintxServiceParameters} \
     fluentintegrations/${flintxServiceName}:${flintxServiceVersion})

  echo "Started container ${flintxServiceName} id:${containerId}"
  for secret in $(echo "${flintxServiceSecrets}" | jq -r '.[] | @base64'); do
    serviceSecretFile=$(echo "${secret}" | base64 --decode)
    echo "Uploading secret ${serviceSecretFile} for service ${flintxServiceName}"
    docker cp secret/"${serviceSecretFile}" "${flintxServiceName}":/config
  done

  for config in $(echo "${flintxServiceConfigs}" | jq -r '.[] | @base64'); do
    serviceConfigFile=$(echo "${config}" | base64 --decode)
    echo "Uploading config ${serviceConfigFile} for service ${flintxServiceName}"
    docker cp config/"${serviceConfigFile}" "${flintxServiceName}":/config
  done

  echo "Done service: ${flintxServiceName}"
done