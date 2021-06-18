#!/bin/bash

# 숫자만 저장
#VER=kubectl version | grep '^Client' | awk -F, '{print $2}'
#VERSION=`kubectl version | grep '^Client' | awk -F, '{print $2}' | awk -F: '{print $2}'`

echo -e "Tanzu Namespace : \c "
read -a NAMESPACE
echo -e "Tanzu Cluster : \c "
read -a CLUSTER
echo -e "Password : \c"
stty -echo
read -a PWD
stty echo

SERVER='https://10.30.10.1'
USER='administrator@vsphere.local'
export KUBECTL_VSPHERE_PASSWORD=$PWD
#NAMESPACE='ss-infra'
#CLUSTER='ss-infra-cluster'
#SECURE_SKIP='--insecure-skip-tls-verify'

kubectl vsphere login --server=$SERVER --vsphere-username=$USER --tanzu-kubernetes-cluster-namespace=$NAMESPACE --tanzu-kubernetes-cluster-name=$CLUSTER
