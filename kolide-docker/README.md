# Kolide Docker

## Generate OpenSSL cert for NGINX
1. `openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout conf/nginx/certs/kolide.key -out conf/nginx/certs/kolide.crt -subj "/C=US/ST=NY/L=Rochester/O=Example/OU=IT Department/CN=example.com"`

## Generate auth_jwt_key for Kolide
1. `openssl rand -base64 32`
    1. Copy key
1. `sed -i 's#changeme#<secret key>#g' conf/kolide/kolide.yml`

## Spin up Kolide stack
1. `docker build -f Dockerfile-kolide -t kolide .`
1. `docker stack deploy --compose-file docker-compose-stack.yml kolide`

### Setup Kolide
1. Open a web browser
1. Browse to `https://<docker IP>`
1. Setup User
    1. Enter `admin` for username
    1. Enter password
    1. Re-enter password
    1. Enter e-mail
1. Setup organization
    1. Enter organization name
    1. Enter URL for organization
1. Set Kolide URL
    1. Enter FQDN for Kolide

## Osquery scale test
1. `docker build --build-arg osquery_enroll_secret="<Kolide auth key>" -f Dockerfile-osquery -t osquery-client .`
1. `docker stack deploy --compose-file docker-compose-osquery-test-stack.yml osquery-scale-test`
1. `docker service scale osquery-scale-test_osquery-client=100`

## References
### Kolide
* [Kolide Fleet on Ubuntu](https://github.com/kolide/fleet/blob/master/docs/infrastructure/fleet-on-ubuntu.md)
* [Github - Kolide NGINX config](https://github.com/Benster900/BlogProjects/blob/master/Kolide/conf/nginx/nginx_kolide.conf)

### Docker
* [Add User to Docker Container](https://stackoverflow.com/questions/27701930/add-user-to-docker-container)
* [Dockerhub - MySQL](https://hub.docker.com/_/mysql)
* [Dockerhub - Redis](https://hub.docker.com/_/redis)
* [Dockerhub - NGINX](https://hub.docker.com/_/nginx)
* [Docker ENTRYPOINT & CMD: Dockerfile best practices](https://medium.freecodecamp.org/docker-entrypoint-cmd-dockerfile-best-practices-abc591c30e21)

### NGINX
* [How to pass arguments like “Country Name” to OpenSSL when creating self signed certificate?](https://superuser.com/questions/1160382/how-to-pass-arguments-like-country-name-to-openssl-when-creating-self-signed-c)
* [HowTo: Create CSR using OpenSSL Without Prompt (Non-Interactive)](https://www.shellhacks.com/create-csr-openssl-without-prompt-non-interactive/)
* [Redirect all HTTP requests to HTTPS with Nginx](https://bjornjohansen.no/redirect-to-https-with-nginx)
* [NGINX websockets](https://www.nginx.com/blog/websocket-nginx/)
* [Nginx reverse proxy unavailable upstreams in Docker](https://ilhicas.com/2018/04/14/Nginx-Upstream-Unavalailble-Docker.html)

### MySQL
* [StackOverFlow - Check if table exists without using “select from”](https://stackoverflow.com/questions/8829102/check-if-table-exists-without-using-select-from)
* [MySQL ‘show tables’: How do I list the tables in a MySQL database?](https://alvinalexander.com/blog/post/mysql/list-tables-in-mysql-database)

### Osquery
* [Github - palantir/osquery-configuration](https://raw.githubusercontent.com/palantir/osquery-configuration/master/Classic/Servers/Linux/osquery.conf)
* [Github - BlogProjects/Kolide/conf/agents/osquery.flags](https://github.com/CptOfEvilMinions/BlogProjects/blob/master/Kolide/conf/agents/osquery.flags)
* [Installing and running osquery](https://github.com/kolide/fleet/blob/master/docs/infrastructure/fleet-on-ubuntu.md)
