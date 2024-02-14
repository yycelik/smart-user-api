# download tls.crt
kubectl get secret s3t-wildcard-cert-prod -n default -o jsonpath='{.data.tls\.crt}' | base64 --decode > tls.crt

# download tls.key
kubectl get secret s3t-wildcard-cert-prod -n default -o jsonpath='{.data.tls\.key}' | base64 --decode > tls.key

# create p12
openssl pkcs12 -export -in tls.crt -inkey tls.key -name myapp-tls -out keystore.p12



# dev
kubectl create namespace smart-dev

kubectl create secret generic s3t-wildcard-cert-prod-p12 --from-file=keystore.p12=keystore.p12 -n smart-dev
 
kubectl create secret generic smart-certificate --from-literal=password=xxxxx -n smart-dev

kubectl create secret generic smart-database --from-literal=url=192.168.0.203:3306 --from-literal=username=xxxxx --from-literal=password=xxxx -n smart-dev



# prod
kubectl create namespace smart

kubectl create secret generic s3t-wildcard-cert-prod-p12 --from-file=keystore.p12=keystore.p12 -n smart

kubectl create secret generic smart-certificate --from-literal=password=xxxxx -n smart

kubectl create secret generic smart-database --from-literal=url=192.168.0.203:3306 --from-literal=username=xxxxx --from-literal=password=xxxxx -n smart
