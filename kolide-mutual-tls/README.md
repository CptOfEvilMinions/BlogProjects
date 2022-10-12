# Kolide + Mutual TLS

## Spin up stack
1. `git clone https://github.com/CptOfEvilMinions/BlogProjects.git`
1. `cd BlogProjects/kolide-mutual-tls`
1. `openssl rand -base64 32`
1. `sed -i 's#super_secret_key_here#<output from openssl>#g' conf/kolide/kolide.yml`
1. `docker-compose build`
1. `docker-compose run --rm kolide fleet prepare db --config /etc/kolide/kolide.yml`
1. `docker-compose up -d`


## Test client certs with curl
```
curl https://kolide.<domain>:8443/api/v1/osquery/enroll \
  --cacert conf/tls/root_ca/*.crt \
  --key conf/tls/client/*.key \
  --cert conf/tls/client/*.crt
```

## Supported software
* Ubuntu Server 20.04 64-bit
* Kolide v3.1.0
* Osquery v4.4.0

## References
* [CptOfEvilMinions/BlogProjects - Docker-vault/conf/nginx/mutual-tls.conf](https://github.com/CptOfEvilMinions/BlogProjects/blob/master/Docker-vault/conf/nginx/mutual-tls.conf)
* [CptOfEvilMinions/Kolide-Docker](https://github.com/CptOfEvilMinions/Kolide-Docker)
* [CLIENT-SIDE CERTIFICATE AUTHENTICATION WITH NGINX](https://fardog.io/blog/2017/12/30/client-side-certificate-authentication-with-nginx/)
* [Install and Setup Kolide Fleet on Ubuntu 18.04](https://kifarunix.com/install-and-setup-kolide-fleet-on-ubuntu-18-04/)
* [Using client certificate in Curl command](https://stackoverflow.com/questions/31305376/using-client-certificate-in-curl-command)
* [Github - CptOfEvilMinions/Kolide-Docker](https://github.com/CptOfEvilMinions/Kolide-Docker)
* [Dockerhube - Kolide/fleet](https://hub.docker.com/r/kolide/fleet/tags)
* [The magic of TLS, X509 and mutual authentication explained](https://medium.com/sitewards/the-magic-of-tls-x509-and-mutual-authentication-explained-b2162dec4401)
* [Osquery - Remote authentication](https://osquery.readthedocs.io/en/stable/deployment/remote/#tls-client-auth-enrollment)
* [Github - kolide/fleet - example_osquery.flags](https://github.com/kolide/fleet/blob/master/tools/osquery/example_osquery.flags)
* [Github - kolide/fleet - Configuring The Fleet Binary](https://github.com/kolide/fleet/blob/master/docs/infrastructure/configuring-the-fleet-binary.md)
* [Osquery - Command Line Flags](https://osquery.readthedocs.io/en/stable/installation/cli-flags/)
* [Build Your Own Certificate Authority (CA)](https://learn.hashicorp.com/tutorials/vault/pki-engine)
* []()
* []()
* []()
