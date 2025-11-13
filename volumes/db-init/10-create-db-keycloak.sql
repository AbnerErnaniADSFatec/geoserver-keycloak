CREATE ROLE keycloak WITH LOGIN PASSWORD 'keycloak';
CREATE DATABASE keycloak TEMPLATE template1 OWNER keycloak;
