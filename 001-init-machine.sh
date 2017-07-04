#!/bin/bash

set -x

# install kubectl and kubeadm
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
        https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

setenforce 0
yum -y install bash-completion docker kubelet kubeadm git
yum -y update
systemctl enable kubelet.service
systemctl enable docker.service
echo 'net.bridge.bridge-nf-call-iptables = 1' > /etc/sysctl.d/01-bridge-nf-call-iptables.conf
sleep 5
shutdown -r now
