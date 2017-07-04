# setup-kubernetes
demo scripts for kubernetes setup

# init machines

This command must be executed on every machine in the cluster

`curl -sSq https://raw.githubusercontent.com/git001/setup-kubernetes/master/001-init-machine.sh|bash -s`

# init kube cluster

this command must be executed on the master only

`curl -sSq https://raw.githubusercontent.com/git001/setup-kubernetes/master/002-init-kube-cluster.sh | bash -s`

# join kubernetes node

## on master

every command must be executed as user ***kubeadmin***

get the master token.

`sudo kubeadm token list|awk '/kubeadm init/ {print $1}'`

get the master api address.

`kubectl config view -o jsonpath='{.clusters[?(@.name == "kubernetes")].cluster.server}'|sed -e 's|https://||'`

## on node

execute the command to join the node to the cluster as root

`kubeadm join --token <THE_TOKEN> <MASTER_API_ADDRESS>`
