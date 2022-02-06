vagrant up
certificateAuthorityData=`vagrant ssh kmaster -c "sudo cat /etc/kubernetes/admin.conf" | grep certificate-authority-data`
clientCertificateData=`vagrant ssh kmaster -c "sudo cat /etc/kubernetes/admin.conf" | grep client-certificate-data`
clientKeyData=`vagrant ssh kmaster -c "sudo cat /etc/kubernetes/admin.conf" | grep client-key-data`
sed -i -bakup 's/^.*.certificate-authority-data.*/'"$certificateAuthorityData"'/g' config
sed -i -bakup 's/^.*.client-certificate-data.*/'"$clientCertificateData"'/g' config
sed -i -bakup 's/^.*.client-key-data.*/'"$clientKeyData"'/g' config
cp config ~/.kube/config 
kubectl config use-context vagrant
kubectl get nodes
cd vault
./vault.sh
