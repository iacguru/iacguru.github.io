#!/bin/bash

echo "[TASK 1] Pull required containers"
kubeadm config images pull >/dev/null 2>&1

echo "[TASK 2] Initialize Kubernetes Cluster"
kubeadm init --apiserver-advertise-address=192.168.56.100 --pod-network-cidr=192.168.0.0/16 >> /root/kubeinit.log 2>/dev/null

echo "[TASK 3] Deploy Calico network"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://docs.projectcalico.org/v3.18/manifests/calico.yaml >/dev/null 2>&1

echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh 2>/dev/null

echo "Kubeconfig setup"
export KUBECONFIG=/etc/kubernetes/admin.conf
echo "[TASK 5] Create a user on the master machine then go into its home directory to perform the remaining steps."
useradd -m -p password kadmin
cd /home/kadmin
kubectl --kubeconfig=/etc/kubernetes/admin.conf create clusterrolebinding kadmin --clusterrole=cluster-admin --user=kadmin
echo "[TASK 6] Create a private key:"
openssl genrsa -out kadmin.key 2048
echo "[TASK 7] Create a certificate signing request (CSR). CN is the username"
openssl req -new -key kadmin.key \
  -out kadmin.csr \
  -subj "/CN=kadmin"
echo "[TASK 8] Sign the CSR with the Kubernetes CA. We have to use the CA cert and key which are normally in /etc/kubernetes/pki/. Our certificate will be valid for 500 days."
openssl x509 -req -in kadmin.csr \
  -CA /etc/kubernetes/pki/ca.crt \
  -CAkey /etc/kubernetes/pki/ca.key \
  -CAcreateserial \
  -out kadmin.crt -days 500
echo "[TASK 9] Create a “.certs” directory where we are going to store the user public and private key."
  mkdir .certs && mv kadmin.crt kadmin.key .certs
echo "Create the user inside Kubernetes."
  kubectl --kubeconfig=/etc/kubernetes/admin.conf config set-credentials kadmin \
  --client-certificate=/home/kadmin/.certs/kadmin.crt \
  --client-key=/home/kadmin/.certs/kadmin.key
echo "[TASK 10] Create a context for the user"
kubectl --kubeconfig=/etc/kubernetes/admin.conf config set-context kadmin@kubernetes \
  --cluster=kubernetes --user=kadmin
mkdir .kube
cp /etc/kubernetes/admin.conf .kube/config
#sed 's/kubernetes-admin/kadmin/g; s/^.*.client-certificate-data.*/    client-certificate-data: \/home\/kadmin\/.certs\/kadmin.crt/g; s/^.*.client-key-data.*/    client-key-data: \/home\/kadmin\/.certs\/kadmin.key/g' /etc/kubernetes/admin.conf > .kube/config
chown -R kadmin: /home/kadmin/
