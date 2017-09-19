# Build
Follows up from [sandy-k8s-registry/README.md](https://github.com/Klazomenai/sandy-k8s-registry)

 - Use Docker from within Minikube
```sh
eval $(minikube docker-env)
```

 - Build new Centos Docker image from the Dockerfile in thie repo
```sh
docker build . --tag=registry:5000/zookeeper:latest
```

 - Push newly build image to local Docker registry
```sh
docker push registry:5000/zookeeper:latest
```

 - Build new image on cluster
```sh
kubectl create -f zookeeper.yaml
# or... until we have finished tinkering with install and have an entrypoint
kubectl run zookeeper -it --image=registry:5000/zookeeper:latest
```
