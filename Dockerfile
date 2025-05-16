FROM docker.osgeo.org/geoserver:2.27.1

ADD ./docker/plugins/geoserver-2.27-SNAPSHOT-sec-oauth2-openid-connect-plugin/* \
    /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/

ENTRYPOINT ["/entrypoint.sh"]
