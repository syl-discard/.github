# minikube
if minikube status -p discard-cluster --format "{{.Host}}" | grep -q "Running"; then
  echo "[INFO]\tMinikube is running";
else
  echo "[WARN]\tMinikube is not running, starting Minikube...";
  minikube start --driver=kvm2 --cni=flannel --cpus=4 --memory=16000 -p=discard-cluster;
fi

# minikube addons
if [ "$(minikube -p discard-cluster addons list | grep -E '\bingress\b([[:space:]]|$)' | grep -c 'enabled')" -eq 0 ]; then
  minikube -p discard-cluster addons enable ingress;
fi
if [ "$(minikube -p discard-cluster addons list | grep -E '\bdashboard\b([[:space:]]|$)' | grep -c 'enabled')" -eq 0 ]; then
  minikube -p discard-cluster addons enable dashboard;
fi

# kubectl
# own yaml files
kubectl apply -f . --cluster discard-cluster;

