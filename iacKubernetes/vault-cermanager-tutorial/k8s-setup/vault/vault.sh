#!/bin/bash

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Reset='\033[0m'
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White


helm version

echo -e "${Green} Add the HashiCorp Helm repository.${Reset}${Reset}"
helm repo add hashicorp https://helm.releases.hashicorp.com

echo -e "${Green} Update all the repositories to ensure helm is aware of the latest versions.${Reset}"
helm repo update

echo -e "${Green} Create presistent volume.${Reset}"
kubectl apply -f pv.yaml

echo -e "${Green} Create presistent volume claim.${Reset}"
kubectl apply -f pvc.yaml

echo -e "${Green} Install the latest version of the Vault server running in standalone mode with the Vault Agent Injector service disabled.${Reset}"
helm install vault hashicorp/vault --set "injector.enabled=false"

echo -e "${Green} Sleep for 60seconds${Reset}"
sleep 60

echo -e "${Green} Get all the pods within the default namespace.${Reset}"
kubectl get pods

echo -e "${Green} Get all the services within the default namespace.${Reset}"
kubectl get service

echo -e "${Green} Initialize Vault with one key share and one key threshold.${Reset}"
kubectl exec vault-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > init-keys.json

echo -e "${Green} View the unseal key found in init-keys.json.${Reset}"
cat init-keys.json | jq -r ".unseal_keys_b64[]"

echo -e "${Green} Create a variable named VAULT_UNSEAL_KEY to capture the Vault unseal key.${Reset}"
VAULT_UNSEAL_KEY=$(cat init-keys.json | jq -r ".unseal_keys_b64[]")

echo -e "${Green} Unseal Vault running on the vault-0 pod with the $VAULT_UNSEAL_KEY.${Reset}"
kubectl exec vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY

echo -e "${Green} Get all the pods within the default namespace.${Reset}"
kubectl get pods

echo -e "${Green} View the root token found in init-keys.json.${Reset}"
cat init-keys.json | jq -r ".root_token"

echo -e "${Green} Create a variable named VAULT_ROOT_TOKEN to capture the root token.${Reset}"
VAULT_ROOT_TOKEN=$(cat init-keys.json | jq -r ".root_token")

echo -e "${Green} Login to Vault running on the vault-0 pod with the $VAULT_ROOT_TOKEN.${Reset}"
kubectl exec vault-0 -- vault login $VAULT_ROOT_TOKEN

echo -e "${Blue} In the vault pod shell, run vault-pki-config.sh, and then in the host shell, run cert-manager-issuer.sh.${Reset}"

echo -e "${Green} starting an interactive shell session on the vault-0 pod. "${Reset}
kubectl exec --stdin=true --tty=true vault-0 -- /bin/sh