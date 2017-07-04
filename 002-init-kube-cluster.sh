#!/bin/bash

set -x

# init cluster
# https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/
kubeadm init
useradd -G wheel kubeadmin
#visudo
sed -ie 's/^%wheel/#%wheel/' /etc/sudoers
sed -ie '/NOPASSWD/s/^#.*%wheel/%wheel/' /etc/sudoers

su - kubeadmin
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

export MY_TOKEN=$(kubeadm token list|awk '/kubeadm init/ {print $1}')

# http://docs.projectcalico.org/v2.3/getting-started/kubernetes/installation/hosted/kubeadm/
# https://kubernetes.io/docs/concepts/cluster-administration/addons/
# kubectl apply -f http://docs.projectcalico.org/v2.3/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml
# kubectl create -f https://git.io/kube-dashboard
