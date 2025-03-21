## Keycloak in Geoserver

### 1 - Create a client in Keycloak with all settings


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

### 2 - Download the Auth Key Extension in Geoserver

#### A. Identify Geoserver version [https://geoserver.org/download/](https://geoserver.org/download/);

#### B. Download the extension in [https://geoserver.org/release/2.26.2/](https://geoserver.org/release/2.26.2/) using  2.26.1 as example;

#### C. Find the extension in `Security >>> Key authentication`;

#### D. Download Keycloak Authentication [https://build.geoserver.org/geoserver/main/community-latest/geoserver-2.27-SNAPSHOT-sec-keycloak-plugin.zip](https://build.geoserver.org/geoserver/main/community-latest/geoserver-2.27-SNAPSHOT-sec-keycloak-plugin.zip).

### 3 - Unzip the files in extension and move to `/WEB-INF/lib` in geoserver config files, if you are using docker:

```bash
unzip ${AUTH_KEY_PLUGIN_PATH}.zip -d ${AUTH_KEY_PLUGIN_PATH}
```

```bash
docker cp ${AUTH_KEY_PLUGIN_PATH}/. ${CONTAINER_ID}:/usr/local/tomcat/webapps/geoserver/WEB-INF/lib/
```

```bash
unzip ${KEYCLOAK_PLUGIN_PATH}.zip -d ${KEYCLOAK_PLUGIN_PATH}
```

```bash
docker cp ${KEYCLOAK_PLUGIN_PATH}/. ${CONTAINER_ID}:/usr/local/tomcat/webapps/geoserver/WEB-INF/lib/
```

### 4 - Restart the docker container or use `systemctl` comand to restart geoserver service and load extensions and plugins for geoserver:

```bash
docker compose restart
```

### To view the installed files in geoserver:

```bash
docker exec -it geoserver-local bash
```

### 5 - Get the `Keycloak Adapter Config` in the client section in keycloak admin console option `Action >>> Download Adapter Config` (Documentação desatualizada).

### 6 - Create a new `New Authentication Filter` in authentication in geoserver security section.

### 7 - Add this `Authentication Filter` to high position in `web` option at `Filter Chain`.
