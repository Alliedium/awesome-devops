

Prerequisites. 

We should have installed 

- Kubernetes realization `k3d` (k3s-in-Docker). If you have run Alliedium [scripts](https://github.com/Alliedium/awesome-linux-config/tree/master/manjaro#instructions) for Manjaro, `k3d` should be already installed. You can check the installation by the command

```
k3d version
```

If `k3d` is not installed, please, follow the [instruction](https://k3d.io/v5.4.6/#requirements)


- administrative command line tool `kubectl`. If you have run Alliedium [scripts](https://github.com/Alliedium/awesome-linux-config/tree/master/manjaro#instructions) for Manjaro, `kubectl` should be already installed. You can check the installation by the command

```
kubectl version
```
If `kubectl` is not installed, please, follow the [instruction](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/)


- plugin manager `krew` for `kubectl`. If you have run Alliedium [scripts](https://github.com/Alliedium/awesome-linux-config/tree/master/manjaro#instructions) for Manjaro, `krew` should be already installed. You can check the installation by the command

```
kubectl krew version
```

If `krew` is not installed, please, follow the [instruction](https://krew.sigs.k8s.io/docs/user-guide/setup/install/) 


- three plugins for kubectl installed via `krew`: 

    - `ctx` for easy change of context. To install the plugin, please, run the command  
	
	```
	kubectl krew install ctx
	```

    - `ns` for easy change of namespace.  To install the plugin, please, run the command  
	
	```
	kubectl krew install ns
	``` 

    - `konfig` for    To install the plugin, please, run the command  
	
	```
	kubectl krew install konfig
	``` 

Steps

1. Get the contents of the default `kubectl` configuration file

```
nano  ~/.kube/config
```

At the very beginning, the file should be empty


2. Create Kubernetes one-nod cluster named `demo-cluster-1` with local container registry named `demo-registry`

```
k3d cluster create demo-cluster-1 --registry-create demo-registry:12345
```

Creation takes about one minute


3. Get the contents of the default `kubectl` configuration file

```
nano  ~/.kube/config
```

At the very beginning, there should be one cluster `k3d-demo-cluster-1`, one context `k3d-demo-cluster-1`, one user. 
Take into account the `k3d-` prefix to the cluster name, which is used by `kubectl`


4. Let's see the cluster in the cluster list  

```
k3d cluster list
```


5. Since `k3d` is "`k3s` in Docker", let's see the containers that are used for the cluster   

```
docker ps --format "table {{.ID}}\t {{.Image}}\t {{.Ports}}\t \t {{.Names}}"
```

Container named `k3d-demo-cluster-1-serverlb` is running the external LoadBalancer, `k3d-demo-cluster-1-server-0` contains the cluster node, and `demo-registry` includes the local container registry created with the cluster


6. Ger the cluster nodes

```
kubectl get nodes
```


7. Create one more cluster

```
k3d cluster create demo-cluster-2
```

8. See the contents of the kubeconfig file

```
nano ~/.kube/config
```

There are two clusters, two contexts, two users. 
The current context points to the cluster created later: `current-context: k3d-demo-cluster-2`


9.	Get the current context by `kubectl config`

```
kubectl config current-context
```

Output: `k3d-demo-cluster-2`


10. Switch the current context by  `kubectl config`
	
```
kubectl config use-context k3d-demo-cluster-1
```

