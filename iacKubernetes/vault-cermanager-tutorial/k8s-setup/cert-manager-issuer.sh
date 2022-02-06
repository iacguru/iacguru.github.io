#!/bin/bash
Green='\033[0;32m'        # Green
Reset='\033[0m'

echo -e "${Green} Deploy Cert Manager${Reset}"
kubectl create namespace cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.yaml

echo -e "${Green} Get all the pods within the cert-manager namespace.${Reset}"
kubectl get pods --namespace cert-manager

echo -e "${Green} Create a service account named issuer within the default namespace.${Reset}"
kubectl create serviceaccount issuer

echo -e "${Green} Get all the secrets in the default namespace.${Reset}"
kubectl get secrets

echo -e "${Green} Create a variable named ISSUER_SECRET_REF to capture the secret name..${Reset}"
ISSUER_SECRET_REF=$(kubectl get serviceaccount issuer -o json | jq -r ".secrets[].name")

echo -e "${Green} Define an Issuer, named vault-issuer, that sets Vault as a certificate issuer..${Reset}"
cat > vault-issuer.yaml <<EOF
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: vault-issuer
  namespace: default
spec:
  vault:
    server: http://vault.default:8200
    path: pki/sign/example-dot-com
    auth:
      kubernetes:
        mountPath: /v1/auth/kubernetes
        role: issuer
        secretRef:
          name: $ISSUER_SECRET_REF
          key: token
EOF
sleep 60
echo -e "${Green} Create the vault-issuer Issuer.${Reset}"
kubectl apply -f vault-issuer.yaml

echo -e "${Green} Define a certificate named example-com..${Reset}"
cat > example-com-cert.yaml <<EOF
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: example-com
  namespace: default
spec:
  secretName: example-com-tls
  issuerRef:
    name: vault-issuer
  commonName: www.example.com
  dnsNames:
  - www.example.com
EOF

sleep 60
echo -e "${Green} Create the example-com certificate.${Reset}"
kubectl apply -f example-com-cert.yaml

sleep 60
echo -e "${Green} View the details of the example-com certificate.${Reset}"
kubectl describe certificate.cert-manager example-com