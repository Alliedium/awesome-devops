## Container orchestration, Kubernetes basics, part 8, 08 Nov 2022

### Prerequisites ###

- The following commands were executed on VM with [Manjaro Linux distribution](https://manjaro.org/download/) (however, they might be performed on another Linux distribution, but the command might differ, e.g. another package manager etc.)
- Docker installed (see [Lesson 5 prerequisites](../05_docker_basic_commands_postgres_23-aug-2022/README.md))
- Make sure that the steps of [Prerequisites](https://github.com/Alliedium/springboot-api-rest-example/tree/master/.k8s#1-prerequisites)
are completed.

### Steps ###

Follow the steps starting from [Step 7](https://github.com/Alliedium/springboot-api-rest-example/tree/master/.k8s/10-zalando-postgres-ha-operator#7-check-spring-boot-api-installation) of [Example 10](https://github.com/Alliedium/springboot-api-rest-example/tree/master/.k8s/10-zalando-postgres-ha-operator)
from `.k8s` folder of the project [Alliedium/springboot-api-rest-example](https://github.com/Alliedium/springboot-api-rest-example/).

### References ###

1. [Kubernetes explained in pictures: the theme park analogy](https://danlebrero.com/2018/07/09/kubernetes-explained-in-pictures-the-theme-park-analogy/)
2. [Kubernetes services, pods, ingress ... all the basic components](https://www.padok.fr/en/blog/kubernetes-essentials-components-pods-services)
3. [Kubernetes Deployments vs StatefulSets](https://stackoverflow.com/questions/41583672/kubernetes-deployments-vs-statefulsets#:~:text=Deployment%20is%20a%20resource%20to,be%20using%20its%20own%20Volume)
4. [K8s: Deployments vs StatefulSets vs DaemonSets](https://medium.com/stakater/k8s-deployments-vs-statefulsets-vs-daemonsets-60582f0c62d4)
5. [Kubernetes Deployment vs StatefulSet: Which is Right for You?](https://cloud.netapp.com/blog/cvo-blg-kubernetes-deployment-vs-statefulset-which-is-right-for-you)
6. [Chart Tests | Helm - The Kubernetes Package Manager](https://helm.sh/docs/topics/chart_tests/)
7. [Built-in Objects | Helm - The Kubernetes Package Manager](https://helm.sh/docs/chart_template_guide/builtin_objects/)
8. [Template Functions and Pipelines | Helm - The Kubernetes Package Manager](https://helm.sh/docs/chart_template_guide/functions_and_pipelines/)
9. [Template Function List | Helm - The Kubernetes Package Manager](https://helm.sh/docs/chart_template_guide/function_list/)
10. [Go Template Package Documentation](https://pkg.go.dev/text/template)
11. [Sprig Function Documentation](https://masterminds.github.io/sprig/)
12. [Named Templates | Helm - The Kubernetes Package Manager](https://helm.sh/docs/chart_template_guide/named_templates/)
13. [Making the most out of Helm templates](https://blog.palark.com/advanced-helm-templating/)
14. [Helm from basics to advanced](https://banzaicloud.com/blog/creating-helm-charts/)
15. [Helm from basics to advanced — part II](https://banzaicloud.com/blog/creating-helm-charts-part-2/)
16. [13 Best Practices for using Helm — Coder Society](https://codersociety.com/blog/articles/helm-best-practices)
17. [Best Practices | Helm - The Kubernetes Package Manager](https://helm.sh/docs/chart_best_practices/)
18. [Helm Upgrade | Helm - The Kubernetes Package Manager](https://helm.sh/docs/helm/helm_upgrade/)
19. [Values Files | Instructions on how to use the --values flag](https://helm.sh/docs/chart_template_guide/values_files/)
20. [Helm Rollback | Helm - The Kubernetes Package Manager](https://helm.sh/docs/helm/helm_rollback/)
21. [Helm Pull | Helm - The Kubernetes Package Manager](https://helm.sh/docs/helm/helm_pull/)
22. [ArtifactHub](https://artifacthub.io/)
23. [OperatorHub](https://operatorhub.io/)
24. [Apache Ignite](https://ignite.apache.org/)
25. [Couchbase Operator](https://operatorhub.io/operator/couchbase-enterprise)
26. [Longhorn](https://longhorn.io/)
27. [Klipper LoadBalancer in K3S](https://github.com/k3s-io/klipper-lb)