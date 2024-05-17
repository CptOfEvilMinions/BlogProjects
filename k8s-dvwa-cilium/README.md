# k8s-dvwa-cilium

## Init
1. `kubectl create ns dvwa`
1. `kubectl create secret generic -n dvwa mysql --from-literal=mysql-root-password=$(openssl rand -hex 20) --from-literal=mysql-replication-password=$(openssl rand -hex 20) --from-literal=mysql-password=$(openssl rand -hex 20)`
1. Add Helm repo: `helm repo add cilium https://helm.cilium.io`

## Deploy
1. Deploy Cilium with Helm: `helm install cilium cilium/cilium --version 1.15.1 --namespace kube-system -f values-cilium.yaml`
1. Deploy Tetragon with Helm: `helm install tetragon cilium/tetragon -n kube-system`
1. Deploy DVWA with Helm: `helm install dvwa . -n dvwa -f values-dvwa.yaml`



## References
* [BlogProjects/k8s-dvwa](https://github.com/CptOfEvilMinions/BlogProjects/blob/main/k8s-dvwa/README.md)
* [helm/cilium/tetragon](https://artifacthub.io/packages/helm/cilium/tetragon)
* [helm/cilium/cilium](https://artifacthub.io/packages/helm/cilium/cilium)
* [How to install K3s Kubernetes on Ubuntu](https://headworq.org/en/how-to-install-k3s-kubernetes-on-ubuntu/)
* [Quick-Start Guide](https://docs.k3s.io/quick-start)
* []()
* []()
* []()
* []()
