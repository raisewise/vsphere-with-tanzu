#!/bin/bash

echo -e "hostname : \c "
read -a HOSTNAME
echo -e "CA PATH : \c "
read -a CAPATH
echo -e "Key PATH : \c "
read -a KEYPATH
echo -e "admin password : \c "
stty -echo
read -a ADMINPASSWD
stty echo
echo -e "db password : \c"
stty -echo
read -a DBPASSWD
stty echo



wget https://github.com/goharbor/harbor/releases/download/v1.9.4/harbor-offline-installer-v1.9.4.tgz

tar xvf harbor-offline-installer-v1.9.4.tgz

cd harbor/

# harbor.yml default
hostname: reg.mydomain.com
# https: https:
#   certificate: /your/certificate/path
#   private_key: /your/private/key/path
harbor_admin_password: Harbor12345
password: root123

./prepare --with-clair
./install.sh --with-clair