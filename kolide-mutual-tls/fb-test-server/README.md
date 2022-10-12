# FB OsqueryPython test server

## Spin up test server with certs
```
python3 test_http_server.py 8080 --tls --persist \
  --cert ../conf/tls/kolide/*.crt \
  --key ../conf/tls/kolide/*.key \
  --ca ../conf/tls/root_ca/*.crt \
  --test-configs-dir tests \
  --use_enroll_secret \
  --enroll_secret tests/test_enroll_secret.txt \
  --verbose
```

## Spin up Osquery with test server
```
osqueryi --flagfile conf/osquery/osquery_test.flags --verbose
```

## Validating cert chain
### Validate server public cert and server private key
1. `openssl rsa -noout -modulus -in ../conf/tls/kolide/*.key | openssl md5`
1. `openssl x509 -noout -modulus -in ../conf/tls/kolide/*.crt | openssl md5`
The SHA1 hash for each command above should be the same. [If the outputs of the commands differ](https://www.namecheap.com/support/knowledgebase/article.aspx/9771/2238/apache-error-x509checkprivatekeykey-values-mismatch), this means that the chosen private key does not match the certificate.


### Validate server public cert + server private key + root CA
1. `openssl verify -CAfile ../conf/tls/root_ca/*.crt ../conf/tls/kolide/*.crt`
  1. Verify the certificate chain by using the Root CA certificate file while validating the server certificate
1. ``

## References
* [Github osquery/osquery - test_http_server.py](https://github.com/osquery/osquery/blob/29f4694df214bc3bd4e7210873e05bb19374888b/tools/tests/test_http_server.py)
* [Apache error: X509_check_private_key:key values mismatch](https://www.namecheap.com/support/knowledgebase/article.aspx/9771/2238/apache-error-x509checkprivatekeykey-values-mismatch)
* [Get your certificate chain right](https://medium.com/@superseb/get-your-certificate-chain-right-4b117a9c0fce)
* []()
* []()
