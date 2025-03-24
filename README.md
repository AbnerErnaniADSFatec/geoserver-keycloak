## Keycloak in Geoserver

### 1 - Create a client in Keycloak with all settings:


### 2 - Run geoserver in Docker:

```bash
docker compose up -d
```

```bash
docker ps -a
```

### Insert container id in environment variables:

```bash
source .env
```

### Obs.: If you are using docker make sure that the Keycloak Auth address are visible inside container;

```yml
    network_mode: host
```

### 3 - Download and install the geoserver in `localhost` using [https://docs.geoserver.org/main/en/user/installation/linux.html](https://docs.geoserver.org/main/en/user/installation/linux.html):

```bash
sudo unzip geoserver-2.26.2-bin.zip -d /usr/share/geoserver
```

#### Make yourself the owner of the geoserver folder:

```bash
sudo chown -R ${USER} /usr/share/geoserver/
```

#### Start GeoServer by changing into the directory `geoserver/bin` and executing the startup.sh script:

```bash
sh /usr/share/geoserver/bin/startup.sh
```

#### Obs.: Install Java if requested:

```bash
sudo apt-get install openjdk-17-jre-headless/noble-updates
```

#### Change the port before `startup` with `nano /usr/share/geoserver/start.ini`:

```txt
    ## Connector host/address to bind to
    # jetty.http.host=0.0.0.0

    ## Connector port to listen on
    jetty.http.port=8080 <<<<====
```

### To rebuild:

```bash
sudo rm -R /usr/share/geoserver
```

```bash
sudo unzip geoserver-2.26.2-bin.zip -d /usr/share/geoserver
```

```bash
sudo chown -R ${USER} /usr/share/geoserver/
```

### 4 - Download the Auth Extensions for Geoserver, but first identify Geoserver version [https://geoserver.org/download/](https://geoserver.org/download/):

#### A. You can download extensions in [https://geoserver.org/release/2.26.2/](https://geoserver.org/release/2.26.2/) or [https://build.geoserver.org/geoserver/main/community-latest/](https://build.geoserver.org/geoserver/main/community-latest/) using  2.26.1 as example, or findin the selected extension in `Security >>> Key authentication`;

#### B. Download Keycloak Authentication [https://build.geoserver.org/geoserver/main/community-latest/geoserver-2.27-SNAPSHOT-sec-keycloak-plugin.zip](https://build.geoserver.org/geoserver/main/community-latest/geoserver-2.27-SNAPSHOT-sec-keycloak-plugin.zip);

#### C. Download OAuth2 Plugin [https://build.geoserver.org/geoserver/2.26.x/community-latest/geoserver-2.26-SNAPSHOT-sec-oauth2-openid-connect-plugin.zip](https://build.geoserver.org/geoserver/2.19.x/community-latest/geoserver-2.26-SNAPSHOT-sec-oauth2-openid-connect-plugin.zip).

### 5 - Unzip the files and move to `/WEB-INF/lib` in geoserver config files:

#### A. If you are using docker:

```bash
unzip ${AUTH_KEY_PLUGIN_PATH}.zip -d ${AUTH_KEY_PLUGIN_PATH}/
```

```bash
docker cp ${AUTH_KEY_PLUGIN_PATH}/. ${CONTAINER_ID}:/usr/local/tomcat/webapps/geoserver/WEB-INF/lib/
```

```bash
unzip ${KEYCLOAK_PLUGIN_PATH}.zip -d ${KEYCLOAK_PLUGIN_PATH}/
```

```bash
docker cp ${KEYCLOAK_PLUGIN_PATH}/. ${CONTAINER_ID}:/usr/local/tomcat/webapps/geoserver/WEB-INF/lib/
```

```bash
unzip ${OAUTH2_PLUGIN_PATH}.zip -d ${OAUTH2_PLUGIN_PATH}/
```

```bash
docker cp ${OAUTH2_PLUGIN_PATH}/. ${CONTAINER_ID}:/usr/local/tomcat/webapps/geoserver/WEB-INF/lib/
```
#### Restart the docker container or use `systemctl` comand to restart geoserver service and load extensions and plugins for geoserver:

```bash
docker compose restart
```

#### To view the installed files in geoserver:

```bash
docker exec -it geoserver-local bash
```

#### B. If you are using Geoserver local unzip the files in `/usr/share/geoserver/webapps/geoserver/WEB-INF/lib`:

```bash
unzip ${AUTH_KEY_PLUGIN_PATH}.zip -d /usr/share/geoserver/webapps/geoserver/WEB-INF/lib
```

```bash
unzip ${KEYCLOAK_PLUGIN_PATH}.zip -d  /usr/share/geoserver/webapps/geoserver/WEB-INF/lib
```

```bash
unzip ${OAUTH2_PLUGIN_PATH}.zip -d /usr/share/geoserver/webapps/geoserver/WEB-INF/lib
```

### 6 - Get the `Keycloak Adapter Config` in the client section in keycloak admin console option `Action >>> Download Adapter Config` (Documentação desatualizada);

### 7 - Get `well-known` config for Keycloak in [https://localhost/iam/realms/TerraCollect-dev-env/.well-known/openid-configuration](https://localhost/iam/realms/TerraCollect-dev-env/.well-known/openid-configuration);

### 8 - Create a new `New Authentication Filter` in authentication in geoserver security section;

### 9 - Add this `Authentication Filter` to high position in `web` option at `Filter Chain`.
