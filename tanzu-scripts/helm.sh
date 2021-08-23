#!/bin/sh

# Install
wget -P $HOME https://get.helm.sh/helm-v2.16.1-linux-amd64.tar.gz
tar xvf $HOME/helm-v2.16.1-linux-amd64.tar.gz
sudo cp $HOME/linux-amd64/helm /usr/local/bin
helm version
helm init --service-account tiller --history-max 200 --tiller-tls-cert /usr/local/share/ca-certificates/ca.crt

# kubeapps
#  @ Token
kubectl create --namespace default serviceaccount kubeapps-operator
kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator
kubectl get secret $(kubectl get serviceaccount kubeapps-operator -o jsonpath='{range .secrets[*]}{.name}{"\n"}{end}' | grep kubeapps-operator-token) -o jsonpath='{.data.token}' -o go-template='{{.data.token | base64decode}}' && echo
#  @ Install
helm repo add bitnami https://charts.bitnami.com/bitnami
kubectl create namespace kubeapps
helm install kubeapps -n kubeapps --set ingress.enabled=true --set ingress.hostname=kubeapps.cnd.lab bitnami/kubeapps

# ! repository
#  $ helm repo add stable https://charts.helm.sh/stable
#  $ helm repo add bitnami https://charts.bitnami.com/bitnami
#  $ helm repo add percona https://percona.github.io/percona-helm-charts

