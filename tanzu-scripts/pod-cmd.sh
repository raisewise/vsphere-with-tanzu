#!/bin/sh

POD=`kubectl get pod | grep -v NAME | awk '{print $1}'`

do echo $i ; kubectl exec -it $i -- df -h