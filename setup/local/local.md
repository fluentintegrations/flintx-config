# Running FlintX Local
## Prerequisites
- jq (https://stedolan.github.io/jq/)
- docker (https://www.docker.com/)

## Configuration
The _local_ folder contains the relevant configuration files which are required to run FlintX services locally:

- [_config_](local%2Fconfig) <br>
  Folder contains the configuration files for each FlintX service.
- [_secret_](local%2Fsecret) folder contains the secret files for each FlintX service.
  - [_flintx-environment.json_](local%2Fsecret%2Fflintx-environment.json)
    This file contains secrets relevant to the FlintX environment.
  - [_{{account.id}}-{{retailer.id}}.json_](local%2Fsecret%2Ffluentmock-1.json)
    Per configured Fluent Commerce account & retailer, a corresponding secrets file is required.

## Startup
Example:
```shell
$ mvn quarkus:dev \
    -Dorg.apache.camel.jmx.disabled=true \
    -Dquarkus.log.level=DEBUG \
    -Dquarkus.kubernetes-config.enabled=false \
    -Dflintx.platform.type=local \
    -Dflintx.config.folder=../../flintx-config/setup/local/config/ \
    -Dflintx.secret.folder=../../flintx-config/setup/local/secret/
```