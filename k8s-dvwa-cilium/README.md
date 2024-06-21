# k8s-dvwa-cilium

## Install/Setup k3s, Cilium, Tetragon, Kubectl
### Install/Setup k3s
1. ssh to Ubuntu VM
1. `sudo su`
1. Curl automated script to install k3s: `curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC='--flannel-backend=none --disable-network-policy' sh -`
    1. By default K3s install includes flannel as the CNI and enables certain network policies, per the documentation we need to disable those
1. Copy `/etc/rancher/k3s/k3s.yaml` to local machine to access Kubernetes (k8s) via kubectl
1. Allow access to k8s API via UFW: `ufw allow 6443/tcp`
1. Allow k8s network communication: `ufw allow from 10.42.0.0/16`
1. Allow k8s network communication: `ufw allow from 10.43.0.0/16`
1. `exit`

### Setup kubectl
1. [Install Kubectl on local machine](https://kubernetes.io/docs/tasks/tools/#kubectl)
1. Pull kubectl config from k3s: `scp <username>@<k3s IP addr>:/etc/rancher/k3s/k3s.yaml ~/.kube/config`
1. Replace localhost IP addr: `cat /etc/rancher/k3s/k3s.yaml | sed 's#127.0.0.1#<k3s IP addr>#g'`
1. Verify config is working: `kubectl get pods -n kube-system`

### Install/Setup MetalLB
1. `git clone https://github.com/CptOfEvilMinions/BlogProjects`
1. `cd BlogProjects/k8s-dvwa-cilium`
1. Install MetalLB: `kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.10/config/manifests/metallb-native.yaml`
1. `vim conf/k3s/metallb-ip-pool.yaml` and set IP range
```yaml
---
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default
  namespace: metallb-system
spec:
  addresses:
  - <IP start addr>-<IP end addr>
  autoAssign: true
```
1. `kubectl apply -f conf/k3s/metallb-ip-pool.yaml`

### Install/Setup Cilium
1. Install Cilium via Helm: `cilium install --version 1.15.5 --set=ipam.operator.clusterPoolIPv4PodCIDRList="10.42.0.0/16"`
1. [Install Cilium CLI on your local machine](https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/#install-the-cilium-cli)
1. Enable Cilium Hubble: `cilium hubble enable --ui`
1. Wait until everything turns green: `cilium status --wait`
```shell
➜  ~ cilium status --wait
    /¯¯\
 /¯¯\__/¯¯\    Cilium:             OK
 \__/¯¯\__/    Operator:           OK
 /¯¯\__/¯¯\    Envoy DaemonSet:    disabled (using embedded mode)
 \__/¯¯\__/    Hubble Relay:       OK
    \__/       ClusterMesh:        disabled

Deployment             hubble-relay       Desired: 1, Ready: 1/1, Available: 1/1
DaemonSet              cilium             Desired: 1, Ready: 1/1, Available: 1/1
Deployment             hubble-ui          Desired: 1, Ready: 1/1, Available: 1/1
Deployment             cilium-operator    Desired: 1, Ready: 1/1, Available: 1/1
Containers:            cilium             Running: 1
                       hubble-ui          Running: 1
                       cilium-operator    Running: 1
                       hubble-relay       Running: 1
Cluster Pods:          15/17 managed by Cilium
Helm chart version:
Image versions         cilium             quay.io/cilium/cilium:v1.15.5@sha256:4ce1666a73815101ec9a4d360af6c5b7f1193ab00d89b7124f8505dee147ca40: 1
                       hubble-ui          quay.io/cilium/hubble-ui:v0.13.0@sha256:7d663dc16538dd6e29061abd1047013a645e6e69c115e008bee9ea9fef9a6666: 1
                       hubble-ui          quay.io/cilium/hubble-ui-backend:v0.13.0@sha256:1e7657d997c5a48253bb8dc91ecee75b63018d16ff5e5797e5af367336bc8803: 1
                       cilium-operator    quay.io/cilium/operator-generic:v1.15.5@sha256:f5d3d19754074ca052be6aac5d1ffb1de1eb5f2d947222b5f10f6d97ad4383e8: 1
                       hubble-relay       quay.io/cilium/hubble-relay:v1.15.5@sha256:1d24b24e3477ccf9b5ad081827db635419c136a2bd84a3e60f37b26a38dd0781: 1
```

### Install/Setup Tetragon on k3s
1. Install Tetragon with Helm: `helm install tetragon cilium/tetragon -n kube-system`
1. [Install Tetragon CLI](https://tetragon.io/docs/installation/tetra-cli/)
1. Create a tunnel to tetragon service: `kubectl port-forward -n kube-system ds/tetragon 54321:54321`
1. Get status: `tetra status`
```shell
➜  ~ tetra status
Health Status: running
```

## Deploy DVWA to k3s with Helm
1. `cd ../k8s-dvwa`
1. Create namespace: `kubectl create ns dvwa`
1. Generate passwords for MySQL: `kubectl create secret generic -n dvwa mysql --from-literal=mysql-root-password=$(openssl rand -hex 20) --from-literal=mysql-replication-password=$(openssl rand -hex 20) --from-literal=mysql-password=$(openssl rand -hex 20)`
1. Deploy DVWA: `helm install dvwa . -n dvwa -f values.yaml`
1. Create k8s load balancer: `kubectl apply -f conf/dvwa/load-balancer.yaml`
1. Wait two minutes for MySQL to start and initialize
1. Get IP addr of k8s load balancer: `kubectl get svc -n dvwa dvwa-load-balancer-external-access`
1. Open browser to `http://<DVWA IP addr>/login.php`
1. Login
    1. Username: `admin`
    1. Password: `password`
1. Select "Create / Reset Database"
1. Re-login

## References
* [BlogProjects/k8s-dvwa](https://github.com/CptOfEvilMinions/BlogProjects/blob/main/k8s-dvwa/README.md)
* [helm/cilium/tetragon](https://artifacthub.io/packages/helm/cilium/tetragon)
* [helm/cilium/cilium](https://artifacthub.io/packages/helm/cilium/cilium)
* [How to install K3s Kubernetes on Ubuntu](https://headworq.org/en/how-to-install-k3s-kubernetes-on-ubuntu/)
* [Quick-Start Guide](https://docs.k3s.io/quick-start)
* [syscall - sys_close](https://elixir.bootlin.com/linux/latest/source/tools/include/nolibc/sys.h#L203)
* [MicroK8s Addon: Hostpath Storage](https://microk8s.io/docs/addon-hostpath-storage)
* [syscall - dup](https://man7.org/linux/man-pages/man2/dup.2.html)
* [syscall - clone](https://linux.die.net/man/2/clone)
* [Detection and Blocking with BPF via YAML](https://troopers.de/downloads/troopers23/TR23_DetectionAndBlockingWithBPFViaYAML.pdf)
* [Tetragon Demo Fileless](https://hackmd.io/@krol/HJ3UiFSmi)
* [syscall - execve](https://man7.org/linux/man-pages/man2/execve.2.html)
* [Can sys_execve() still return with error after begin_new_exec() returns zero?](https://stackoverflow.com/questions/74301741/can-sys-execve-still-return-with-error-after-begin-new-exec-returns-zero)
* [syscall - execve](https://linux.die.net/man/2/execve)
* [Google Cloud Logging and Cloud Monitoring example with Tetragon](https://medium.com/google-cloud/google-cloud-logging-and-cloud-monitoring-example-with-tetragon-5eb2012066d4)
* [The Difference Between fork(), vfork(), exec() and clone()](https://www.baeldung.com/linux/fork-vfork-exec-clone)
* [Dockerhub - php:8-apache](https://hub.docker.com/layers/library/php/8-apache/images/sha256-3dd4df7bdf81a042b2f93bf582c7a98f54fd14b7ab7976e3d6e7fef03af73a8c?context=explore)
* [DVWA/Dockerfile](https://github.com/digininja/DVWA/blob/master/Dockerfile)
* [syscall - write](https://man7.org/linux/man-pages/man2/write.2.html)
* [The eBPF - 2](https://blog.rudrasecure.com/the-ebpf-2)
* [Quick Exploration of Tetragon — A Security Observability and Execution Tool Based on eBPF](https://addozhang.medium.com/quick-exploration-of-tetragon-a-security-observability-and-execution-tool-based-on-ebpf-b67ddc84886d)
* [Tetragon - Documentation/Concepts/Tracing Policy/Selectors](https://tetragon.io/docs/concepts/tracing-policy/selectors/#selector-semantics)
* [Tetragon - Documentation/Concepts/Tracing Policy/Hook points](https://tetragon.io/docs/concepts/tracing-policy/hooks/)
* [Tetragon - Documentation/Getting Started/Policy Enforcement](https://tetragon.io/docs/getting-started/enforcement/)
* [Tetragon Observability Policies](https://tetragon.io/docs/policy-library/observability/#egress-connections)
* [Policy Enforcement](https://tetragon.io/docs/getting-started/enforcement/)
* [CptOfEvilMinions/BlogProjects/tree/main/k8s-dvwa](https://github.com/CptOfEvilMinions/BlogProjects/tree/main/k8s-dvwa)
* [Damn Vulnerable Web Application (DVWA): Command Injection](https://medium.com/@timel3ssn3ss/damn-vulnerable-web-application-dvwa-command-injection-1c1b9950c9d3)
* [Writeups for Damn Vulnerable Web Application (DVWA)](https://infosecwriteups.com/writeups-for-damn-vulnerable-web-application-dvwa-ba42a43afca1)
* [SQL Injection Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html)
* [Cilium/Overview of Network Policy/Layer 3 Examples](https://docs.cilium.io/en/latest/security/policy/language/#dns-based)
* [Tetragone: A Lesson in Security Fundamentals](https://grsecurity.net/tetragone_a_lesson_in_security_fundamentals)
* [File Monitoring with eBPF and Tetragon (Part 1)](https://isovalent.com/blog/post/file-monitoring-with-ebpf-and-tetragon-part-1/)
* [tetragon: Add support to override security_ functions #1609](https://github.com/cilium/tetragon/pull/1609/files)
* [syscall - openat](https://linux.die.net/man/2/openat)
* [Using bcc-tools for anomaly detection, performance analysis, troubleshooting and observability of the Linux kernel and user-space applications](https://medium.com/@linux.ts24/using-bcc-tools-for-anomaly-detection-performance-analysis-troubleshooting-and-observability-of-7bb50fd08992)
* [BPF Compiler Collection (BCC)](https://github.com/iovisor/bcc?tab=readme-ov-file)
* [tools/filetop.py](https://github.com/iovisor/bcc/blob/master/tools/filetop.py)
* [pkg/k8s/apis/cilium.io/client/crds/v1alpha1/cilium.io_tracingpolicies.yaml](https://github.com/cilium/tetragon/blob/main/pkg/k8s/apis/cilium.io/client/crds/v1alpha1/cilium.io_tracingpolicies.yaml)
* [Isovalent Enterprise for Tetragon: Deeper Host Network Observability with eBPF](https://isovalent.com/blog/post/tetragon-network-observability-dashboards/)
* [Exploring Tetragon - A Security Observability Tool for Kubernetes, Docker, and Linux](https://labs.iximiuz.com/tutorials/introduction-to-tetragon)
* [helm/cilium/tetragon](https://artifacthub.io/packages/helm/cilium/tetragon?modal=values)
* [Tetragon - Documentation/Getting Started/Execution Monitoring/Execution Monitoring](https://tetragon.io/docs/getting-started/execution/)
* [Layer 3 Examples](https://docs.cilium.io/en/latest/security/policy/language/#limit-ingress-egress-ports)
* [3-node K3S cluster with etcd and MetalLB on bare-metal systems](https://medium.com/@eng.fernandosilva/3-node-k3s-cluster-with-etcd-and-metallb-4ddc7dcfb303)
* [Installation Using K3s](https://docs.cilium.io/en/stable/installation/k3s/)
* [Service Map & Hubble UI](https://docs.cilium.io/en/stable/gettingstarted/hubble/)
* [User Story 4 – Frontend Accepts World Ingress Traffic via TCP Only](https://isovalent.com/blog/post/tutorial-cilium-network-policy/#user-story-4-frontend-accepts-world-ingress-traffic-via-tcp-only)
* [Exploring Network Policies with Cilium](https://www.civo.com/learn/network-policies-with-cilium)
* [Mastering Kubernetes with Cilium: Empowering L7 Traffic Control](https://nws.netways.de/blog/2023/09/05/l7-traffic-filtering-with-cilium/)
* [Securing Your Kubernetes Cluster: Cilium and Network Policies](https://learncloudnative.com/blog/2023-06-14-cilium-network-policy)
* [DNS for Services and Pods](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/)
* [Kubernetes Network Policies Using Cilium - Controlling Ingress/Egress from Namespaces](https://cilium.io/blog/2018/09/19/kubernetes-network-policies/)
* [examples/tracingpolicy/open_kill.yaml](https://github.com/cilium/tetragon/blob/main/examples/tracingpolicy/open_kill.yaml)
* [Tutorial: Cilium Network Policy in Practice (Part 2)](https://isovalent.com/blog/post/tutorial-cilium-network-policy/)
* [How to hide your actions when every step is being monitored](https://offzone.moscow/upload/iblock/e3b/g6q7ndv0uu3e2lp6ebyneakm9hhw5oyw.pdf)
* [Mastering Web Security: Testing OWASP Top 10 with DVWA](https://medium.com/@rajasaud260/mastering-web-security-testing-owasp-top-10-with-dvwa-814b0d43422e)
* [DVWA SQL INJECTION](https://medium.com/@aayushtiruwa120/dvwa-sql-injection-91b4efb683e4)
* [Understanding File Inclusion Attack using DVWA web application](https://medium.com/@manjuteju008/understanding-file-inclusion-attack-using-dvwa-web-application-30d06846c269)
* [Strengthen your system with Tetragon's eBPF-based Security Observability and Runtime Enforcement capabilities](https://b-nova.com/en/home/content/strengthen-your-system-with-tetragons-ebpf-based-security-observability-and-runtime-enforcement-capabilities/)
* [What Are Kubernetes Endpoints?](https://shahneil.medium.com/what-are-kubernetes-endpoints-and-how-to-use-them-a5a5da56f4d4)
* [DVWA Vulnerability: File Upload](https://h3ckerboi.medium.com/dvwa-vulnerability-file-upload-d422e91ca4c1)
* [WhiteWinterWolf/wwwolf-php-webshell](https://github.com/WhiteWinterWolf/wwwolf-php-webshell)
* [HolyOne/C99Shell-PHP8](https://github.com/HolyOne/C99Shell-PHP8)
* [Dvwa File Upload Vulnerabilities](https://medium.com/@eudorina67/dvwa-file-upload-vulnerabilities-40104b54d488)
* [Linux MySQL Slow Query Tracing with bcc/BPF](https://www.brendangregg.com/blog/2016-10-04/linux-bcc-mysqld-qslower.html)
* [Exploring Function Tracing with eBPF and Uprobes - Episode 1](https://getanteon.com/blog/exploring-function-tracing-with-ebpf-and-uprobes/#:~:text=Uprobes%20enable%20the%20dynamic%20instrumentation,entry%20point%20of%20a%20function.)
* [mysql_send_query](https://mariadb.com/kb/en/mysql_send_query/)
* [Tracing and Profiling MySQL](https://www.percona.com/sites/default/files/ple19-slides/day1-pm/tracing-and-profiling-mysql.pdf)
* [Hook points](https://tetragon.io/docs/concepts/tracing-policy/hooks/#uprobes)
* [Cross Site Scripting(XSS) | DVWA(Damn Vulnerable Web Applications)](https://blackhawkk.medium.com/cross-site-scripting-xss-dvwa-damn-vulnerable-web-applications-36808bff37b3)
* [DVWA CSP Bypass](https://puriayush29.medium.com/dvwa-csp-bypass-4a746830d5a1)
* [DVWA Javascript attacks](https://puriayush29.medium.com/dvwa-javascript-attacks-315308f32b30)
* [DVWA Command Execution solutions (Low,Medium,High)](https://n3dx0o.medium.com/dvwa-command-execution-solutions-low-medium-high-6ee354dc2974)
* [k3s requirements](https://docs.k3s.io/installation/requirements?os=debian)
* [renameat(2) - Linux man page](https://linux.die.net/man/2/renameat)
* [fs/namei.c](https://github.com/torvalds/linux/blob/e5b3efbe1ab1793bb49ae07d56d0973267e65112/fs/namei.c#L5091)
* [rename](https://aquasecurity.github.io/tracee/v0.14/docs/events/builtin/syscalls/rename/)
* [rename(2) — Linux manual page](https://man7.org/linux/man-pages/man2/rename.2.html)
* []()
* []()
* []()
* []()
* []()
* []()
* []()
* []()
* []()
