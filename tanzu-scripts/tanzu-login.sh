#!/bin/bash

echo -e "Tanzu Namespace : \c "
read -a NAMESPACE
echo -e "Tanzu Cluster : \c "
read -a CLUSTER

SERVER='https://10.30.10.1'
USER='administrator@vsphere.local'
#NAMESPACE='ss-infra'
#CLUSTER='ss-infra-cluster'
#SECURE_SKIP='--insecure-skip-tls-verify'

kubectl vsphere login --server=$SERVER --vsphere-username=$USER --tanzu-kubernetes-cluster-namespace=$NAMESPACE --tanzu-kubernetes-cluster-name=$CLUSTER
