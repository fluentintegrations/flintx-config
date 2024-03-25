# Running FlintX on Docker
## Prerequisites
- jq (https://stedolan.github.io/jq/)
- docker (https://www.docker.com/)

## Configuration
The docker folder contains the relevant scripts and configuration files which are used for the setup of FlintX on Docker:

- [_flintx-fluent-docker-config-arm64.json_](docker%2Fflintx-fluent-docker-config-arm64.json) and
  [_flintx-fluent-docker-config-amd64.json_](docker%2Fflintx-fluent-docker-config-amd64.json) <br>
  Defines the available configuration details as well as specific configurations for each FlintX service.
- [_docker-install.sh_](docker%2Fdocker-install.sh)
  Script which reads the configuration and installs the configured services.
  Example:<br>
  ```$ ./docker-install.sh flintx-fluent-docker-config-arm64.json [all|{{serviceName}}]```
- [_docker-uninstall.sh_](docker%2Fdocker-uninstall.sh)<br>
  Script which reads the configuration and uninstalls the configured services.
  Example:<br>
  ```$ ./docker-uninstall.sh flintx-fluent-docker-config-arm64.json [all|{{serviceName}}]```
- [_config_](docker%2Fconfig) <br>
  Folder contains the configuration files for each FlintX service.
- [_secret_](docker%2Fsecret) folder contains the secret files for each FlintX service.
  - [_flintx-environment.json_](docker%2Fsecret%2Fflintx-environment.json)
    This file contains secrets relevant to the FlintX environment.
  - [_{{account.id}}-{{retailer.id}}.json_](docker%2Fsecret%2Ffluentmock-1.json)
    Per configured Fluent Commerce account & retailer, a corresponding secrets file is required.