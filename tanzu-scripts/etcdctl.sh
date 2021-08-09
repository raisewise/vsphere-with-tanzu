#!/bin/bash

# This script assumes you're running from a master node
# hosting the kube-apiserver.

# Change this based on location of etcd nodes

# ETCDCTL_API=3 etcdctl 
#   --cert /etc/kubernetes/pki/apiserver-etcd-client.crt 
#   --key /etc/kubernetes/pki/apiserver-etcd-client.key 
#   --cacert /etc/kubernetes/pki/etcd/ca.crt 
#   get /registry/secrets/default/security | hexdump -C

# sample ./etcctl.sh get /registry/secrets/default/login1

# photon OS
# tdnf -y install etcd
# sudo apt install etcd-client

ENDPOINTS='127.0.0.1:2379'

ETCDCTL_API=3 etcdctl \
  --endpoints=${ENDPOINTS} \
  --cacert="/etc/kubernetes/pki/etcd/ca.crt" \
  --cert="/etc/kubernetes/pki/apiserver-etcd-client.crt" \
  --key="/etc/kubernetes/pki/apiserver-etcd-client.key" \
  ${@}