# Vault + Docker

Hashicorp Vault (Vault) is an open-source tool for managing secrets. This blog post will demonstrate how to use Vault to generate a root CA for trusted TLS communication and how to generate client certificates for mutual TLS communication. Not only does this blog post contain a high-level overview of Vault, it includes working infrastructure-as-code and step-by-step tutorial.

* [Install/Setup Vault for PKI + NGINX + Docker - Becoming your own CA](https://holdmybeersecurity.com/2020/07/09/install-setup-vault-for-pki-nginx-docker-becoming-your-own-ca)


## Spin up vault
1. `docker-compose build`
1. `docker-compose up -d`

## Spin up NGINX with self signed root CA
1. `docker-compose -f docker-compose-signed-cert.yml build`
1. `docker-compose -f docker-compose-signed-cert.yml up -d`

## Spin up NGINX with mutual TLS
1. `docker-compose -f docker-compose-mutual-tls.yml build`
1. `docker-compose -f docker-compose-mutual-tls.yml up -d`

## References
* [Managing Secrets with Vault and Consul](https://testdriven.io/blog/managing-secrets-with-vault-and-consul/)
* [DockerHub - containous/whoami](https://hub.docker.com/r/containous/whoami)
* [Configuring Nginx with client certificate authentication (mTLS)](https://wott.io/blog/tutorials/2019/07/15/mtls-with-nginx)
* [NGinx SSL certificate authentication signed by intermediate CA (chain)](https://stackoverflow.com/questions/8431528/nginx-ssl-certificate-authentication-signed-by-intermediate-ca-chain)
* [Configuring NGINX for Mutual TLS](https://www.docusign.com/blog/dsdev-configuring-nginx-mutual-tls)
