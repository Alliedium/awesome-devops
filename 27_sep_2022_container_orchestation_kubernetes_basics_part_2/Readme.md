## Demo on: Container orchestration, Kubernetes basics, part 2, 27 Sep 2022

Before you begin, please make **Cleaning actions**

```
k3d cluster delete demo-cluster-1
k3d cluster delete demo-cluster-2
```

Please, perform the [Prerequisites](https://github.com/Alliedium/springboot-api-rest-example/tree/master/.k8s#prerequisites) 
and [Deployment variants](https://github.com/Alliedium/springboot-api-rest-example/tree/master/.k8s#deployment-variants) 
[1](https://github.com/Alliedium/springboot-api-rest-example/tree/master/.k8s#1-single-pod-with-sidecar-no-persistence-due-to-ephemeral-volume), 
[2](https://github.com/Alliedium/springboot-api-rest-example/tree/master/.k8s#2-only-pods-no-persistence-due-to-ephemeral-volume) 
from ```.k8s``` folder of the project 
[Alliedium/springboot-api-rest-example](https://github.com/Alliedium/springboot-api-rest-example/). 

