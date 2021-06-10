#!/bin/sh



kubectl get virtualmachines $VM -o jsonpath='{.status.vmIp}'
VMIP=kubectl get virtualmachines $VM -o jsonpath='{.status.vmIp}'
VMPW=kubectl get 
kubectl exec -it jumpbox -- /usr/bin/ssh -o StrictHostKeyChecking=no vmware-system-user@$VMIP

kubectl get secrets $VM -o jsonpath='{.data.ssh-passwordkey}' | xargs echo | base64 -d
