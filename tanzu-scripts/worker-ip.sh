#!/bin/bash

echo -e "Tanzu Namespace : \c "
read -a NAMESPACE
TMP=$(kubectl config current-context)
kubectl config use-context $NAMESPACE
for i in `kubectl get virtualmachines | grep -v NAME | awk '{print $1}'`
do
echo $i; 
kubectl get virtualmachines $i -o yaml | grep '^  vmIp'
done
kubectl config use-context $TMP
