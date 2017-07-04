#!/bin/bash

set -x

# init cluster
# https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/
kubeadm init
useradd -G wheel kubeadmin
#visudo
sed -ie 's/^%wheel/#%wheel/' /etc/sudoers
sed -ie '/NOPASSWD/s/^#.*%wheel/%wheel/' /etc/sudoers

systemctl start docker.service
systemctl start kubelet.service

sleep 5

mkdir -p /home/kubeadmin/.kube
cp -i /etc/kubernetes/admin.conf /home/kubeadmin/.kube/config
chown -R kubeadmin:kubeadmin /home/kubeadmin/.kube

export MY_TOKEN=$(kubeadm token list|awk '/kubeadm init/ {print $1}')

# http://docs.projectcalico.org/v2.3/getting-started/kubernetes/installation/hosted/kubeadm/
# https://kubernetes.io/docs/concepts/cluster-administration/addons/
su -l -c 'kubectl apply -f http://docs.projectcalico.org/v2.3/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml' kubeadmin
su -l -c 'kubectl create -f https://git.io/kube-dashboard' kubeadmin
