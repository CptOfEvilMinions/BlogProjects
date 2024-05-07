# k8s-dvwa

## Init
1. `kubectl create ns dvwa`
1. `kubectl create secret generic -n dvwa mysql --from-literal=mysql-root-password=$(openssl rand -hex 20) --from-literal=mysql-replication-password=$(openssl rand -hex 20) --from-literal=mysql-password=$(openssl rand -hex 20)`

## Config
1. `vim k8s-dvwa/templates/config.yaml` and set values

## Deploy
1. `helm install dvwa . -n dvwa -f values.yaml`

## Connect
1. `kubectl port-forward -n dvwa svc/dvwa 8000:80`
1. Open browser to `http://127.0.0.1:8000` and login
    1. Enter `admin` as username
    1. Enter `password` as password
1. Select "Create / Reset Database"
1. Re-login

## References
* [Define Environment Variables for a Container](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)
* [helm/bitnami/mysql](https://artifacthub.io/packages/helm/bitnami/mysql)
* [DVWA/compose.yml](https://github.com/digininja/DVWA/blob/123256873d226f8b71535366fd05807ab6ad1af4/compose.yml)
* []()
* []()
* []()
