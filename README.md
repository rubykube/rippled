# Rippled

## Rippled installation for minikube

### Install and start Minikube

Install for MacOSX
```
brew cask install minikube
brew install kubectl
```
or using
```
# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/darwin/amd64/kubectl

# minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.23.0/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```

Run minikube and set kubeconfig
```
minikube start
kubectl config use-context minikube
```

Configure your docker client to point into minikube docker engine
```
eval $(minikube docker-env)
```

### Git clone this repository and build image

```
git clone https://github.com/rubykube/rippled.git
cd rippled
```

build the docker image into the minikube engine
```
eval $(minikube docker-env)
make build
docker images
```

Create a new deployment
```
make deploy
```

Expose the service onto a VM port
```
kubectl expose deployment $SVCNAME --type=NodePort
```

List all resources and curl your service
```
kubectl get all
curl $(minikube service $SVCNAME --url)
```

Now using helm
```
helm install ./config/charts/rippled
```

Overidding a value:
```
helm install ./config/charts/rippled --set "image.tag=$(cat VERSION)"
or
make deploy
```

Generated with kite :
```
kite generate service --git git@github.com:rubykube/rippled.git --image rippled  --image-version=0.80.0 --chart-version=0.80.0 .
```
