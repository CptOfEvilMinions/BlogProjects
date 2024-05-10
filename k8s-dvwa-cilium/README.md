# k8s-dvwa-cilium

## Install k3s on Ubuntu
1. `sudo su`
1. `curl -sfL https://get.k3s.io | sh -`
1. `ufw default allow routed`
1. `ufw allow in on cni0 from 10.42.0.0/16 coment "K3s rule: allow traffic from kube-system pods"`
1. `ufw allow in on kube-bridge from 10.42.0.0/16 comment "K3s"`
1. `ufw allow from any to any port 6443 comment "K8s: allow access to kube-api from internal network"`
1. `ssh superadmin@<k3s IP addr> "cat /etc/rancher/k3s.config | sed "s#default#dumpster#g" > ~/.kube/configs/dumpster.yaml`

## Init
1. `kubectl create ns dvwa cilium`
1. `kubectl create secret generic -n dvwa mysql --from-literal=mysql-root-password=$(openssl rand -hex 20) --from-literal=mysql-replication-password=$(openssl rand -hex 20) --from-literal=mysql-password=$(openssl rand -hex 20)`

## Deploy
1. `helm install k8s-dvwa-cilium . -n dvwa -f values.yaml`

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
