#!/bin/sh

for i in `kubectl get virtualmachines | grep -v NAME | awk '{print $1}'`
do
echo $i; 
kubectl get virtualmachines $i -o yaml | grep '^  vmIp'
done