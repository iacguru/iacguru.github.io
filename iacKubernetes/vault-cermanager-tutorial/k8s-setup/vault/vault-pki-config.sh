#!/bin/bash
Green='\033[0;32m'        # Green
Reset='\033[0m'
echo -e "${Green} Enable the PKI secrets engine at its default path.${Reset}"
vault secrets enable pki

echo -e "${Green} Configure the max lease time-to-live (TTL) to 8760h.${Reset}"
vault secrets tune -max-lease-ttl=8760h pki

echo -e "${Green} Generate a self-signed certificate valid for 8760h.${Reset}"
vault write pki/root/generate/internal common_name=example.com ttl=8760h

echo -e "${Green} Configure the PKI secrets engine certificate issuing and certificate revocation list (CRL) endpoints to use the Vault service in the default namespace.${Reset}"
vault write pki/config/urls \
    issuing_certificates="http://vault.default:8200/v1/pki/ca" \
    crl_distribution_points="http://vault.default:8200/v1/pki/crl"

echo -e "${Green} Configure a role named example-dot-com that enables the creation of certificates example.com domain with any subdomains.${Reset}"
vault write pki/roles/example-dot-com \
    allowed_domains=example.com \
    allow_subdomains=true \
    max_ttl=72h

echo -e "${Green} Create a policy named pki that enables read access to the PKI secrets engine paths.${Reset}"
vault policy write pki - <<EOF
path "pki*"                        { capabilities = ["read", "list"] }
path "pki/roles/example-dot-com"   { capabilities = ["create", "update"] }
path "pki/sign/example-dot-com"    { capabilities = ["create", "update"] }
path "pki/issue/example-dot-com"   { capabilities = ["create"] }
EOF

echo -e "${Green} Enable the Kubernetes authentication method.${Reset}"
vault auth enable kubernetes

echo -e "${Green} Configure the Kubernetes authentication method to use location of the Kubernetes API, the service account token, its certificate, and the name of Kubernetes' service account issuer (required with Kubernetes 1.21+).${Reset}"
vault write auth/kubernetes/config \
    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
    issuer="https://kubernetes.default.svc.cluster.local"

echo -e "${Green} Finally, create a Kubernetes authentication role named issuer that binds the pki policy with a Kubernetes service account named issuer.${Reset}"
vault write auth/kubernetes/role/issuer \
    bound_service_account_names=issuer \
    bound_service_account_namespaces=default \
    policies=pki \
    ttl=20m

exit
echo "Exiting from Pod!"
