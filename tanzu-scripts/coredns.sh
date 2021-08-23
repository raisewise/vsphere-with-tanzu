#!/bin/sh

kubectl get configmaps -n kube-system coredns -o jsonpath='{.data.Corefile}'