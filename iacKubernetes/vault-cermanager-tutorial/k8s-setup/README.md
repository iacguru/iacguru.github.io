# Set up Kubernetes cluster with 2 Nodes, Calico, Cert-manager and vault-issuer with Helm, Vagrant and Bash.

## Description
Your services can establish their identity and communicate securely over the network with other services or clients inside or outside the cluster when Kubernetes is configured to use Vault as a certificate manager. 

Through an Issuer interface, Jetstack's cert-manager allows Vault's PKI secrets engine to dynamically generate X.509 certificates within Kubernetes. 

The Vault Helm chart is used to set up Vault, as well as the PKI secrets engine and Kubernetes authentication. Then install Jetstack's cert-manager, set it up to use Vault, and submit a certificate request.

## Prerequisites:
 - Vagrant
 - VirtualBox
 - Helm
 - JQ
 - Bash

## Steps 

- 1. Change current directory to k8s-setup
    ``` cd k8s-setup```
- 2. Execute .vagrantUp.sh
    ``` ./vagrantUp.sh```
- 3. Execute vault-pki-config.sh code in pod shell to configure vault PKI engine
- 4. Execute cert-manager-issuer.sh to configure cert-manager and vault issuer.
    ```./cert-manager-issuer.sh```

The following is an example of a successful output.
  ```
  Type    Reason     Age   From          Message
  ----    ------     ----  ----          -------
  Normal  Requested  2m1s  cert-manager  Created new CertificateRequest resource "example-com-zttk5"
  Normal  Issuing    2m    cert-manager  The certificate has been successfully issued
  ```


# References:

## VagrantFile
https://github.com/justmeandopensource/kubernetes/blob/master/vagrant-provisioning/Vagrantfile

## Vault Configuration
https://learn.hashicorp.com/tutorials/vault/kubernetes-cert-manager?in=vault/kubernetes

## Kubernetes documentation used
https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/

https://www.adaltas.com/en/2019/08/07/users-rbac-kubernetes/


