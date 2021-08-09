#!/bin/sh

sudo curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get install vault jq

systemctl start vsult
export VAULT_ADDR='https://vault.cnd.lab:8200'
vault status
vault operator init
vault operator unseal
vault login
export VAULT_TOKEN="s.wxPJv2C8WFZhx1aFHf4G18GW"
curl https://vault.cnd.lab:8200/v1/sys/init
vault auth enable -output-curl-string approle
curl --header "X-Vault-Token: $VAULT_TOKEN" --request POST --data '{"type": "approle"}' https://vault.cnd.lab:8200/v1/sys/auth/approle
curl \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request PUT \
    --data '{"policy":"# Dev servers have version 2 of KV secrets engine mounted by default, so will\n# need these paths to grant permissions:\npath \"secret/data/*\" {\n  capabilities = [\"create\", \"update\"]\n}\n\npath \"secret/data/foo\" {\n  capabilities = [\"read\"]\n}\n"}' \
    https://vault.cnd.lab:8200/v1/sys/policies/acl/my-policy
curl \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request POST \
    --data '{ "type":"kv-v2" }' \
    https://vault.cnd.lab:8200/v1/sys/mounts/secret
curl \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request POST \
    --data '{"policies": ["my-policy"]}' \
    https://vault.cnd.lab:8200/v1/auth/approle/role/my-role
curl \
    --header "X-Vault-Token: $VAULT_TOKEN" \
     https://vault.cnd.lab:8200/v1/auth/approle/role/my-role/role-id | jq -r ".data"
curl \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request POST \
    https://vault.cnd.lab:8200/v1/auth/approle/role/my-role/secret-id | jq -r ".data"
curl --request POST \
       --data '{"role_id": "d99a28e1-5fe6-84a3-de1d-25e12e19fa10", "secret_id": "ffb9a05e-ea0c-507f-04dd-5942a438335f"}' \
       https://vault.cnd.lab:8200/v1/auth/approle/login | jq -r ".auth"
