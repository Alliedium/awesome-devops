## Container orchestration Kubernetes basics: containers, pods, ephemeral volumes ##

### Prerequisites ###

- The following commands were executed on VM with [Manjaro Linux distribution](https://manjaro.org/download/) (however, they might be performed on another Linux distribution, but the command might differ, e.g. another package manager etc.)
- Docker installed (see [Lesson 5 prerequisites](../05_docker_basic_commands_postgres_23-aug-2022/README.md))
- k3d cluster created and set up as per steps of [Lesson 11](../11_k8s_dev_tools_kubectl_krew_vscode_15-sep-2022/README.md) completed
- k3d cluster cleaned up:
```
k3d cluster delete demo-cluster-1
k3d cluster delete demo-cluster-2
```

### Steps ###

Follow the steps of [Prerequisites](https://github.com/Alliedium/awesome-kubernetes/tree/main#1-prerequisites), 
[Example 1](https://github.com/Alliedium/springboot-api-rest-example/blob/master/.k8s/01-single-pod-with-ephemeral-volume), 
and [Example 2](https://github.com/Alliedium/springboot-api-rest-example/blob/master/.k8s/02-pods-with-ephemeral-volume) 
from `.k8s` folder of the project [Alliedium/springboot-api-rest-example](https://github.com/Alliedium/springboot-api-rest-example/).

### References ###

1. [Kubernetes explained in pictures: the theme park analogy](https://danlebrero.com/2018/07/09/kubernetes-explained-in-pictures-the-theme-park-analogy/)
2. [Kubernetes services, pods, ingress ... all the basic components](https://www.padok.fr/en/blog/kubernetes-essentials-components-pods-services)
3. [`gh`: GitHub CLI](https://github.com/cli/cli#readme)
4. [GitHub CLI manual](https://cli.github.com/manual/)
5. [tig — улучшаем продуктивность работы с git](https://habr.com/ru/post/337644/)
6. [Осваиваем эффективную работу в Midnight Commander](https://interface31.ru/tech_it/2020/10/osvaivaem-effektivnuyu-rabotu-v-midnight-commander.html)
7. [Alliedium / springboot-api-rest-example](https://github.com/Alliedium/awesome-kubernetes/tree/main#prerequisites)
8. [Kubernetes | Pods](https://kubernetes.io/docs/concepts/workloads/pods/)
9. [Kubernetes | Volumes | emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)
10. [Pod Lifecycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)
11. [Pod Lifecycle | Container restart policy](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy)
12. [DNS for Services and Pods | Pods](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pods)
13. [Expose Pod Information to Containers Through Environment Variables](https://kubernetes.io/docs/tasks/inject-data-application/environment-variable-expose-pod-information/)