## Container orchestration, Kubernetes basics, part 6, 20 Oct 2022

### Prerequisites ###

- The following commands were executed on VM with [Manjaro Linux distribution](https://manjaro.org/download/) (however, they might be performed on another Linux distribution, but the command might differ, e.g. another package manager etc.)
- Docker installed (see [Lesson 5 prerequisites](../05_docker_basic_commands_postgres_23-aug-2022/README.md))
- k3d cluster created and set up as per steps of [Lesson 11](../11_k8s_dev_tools_kubectl_krew_vscode_15-sep-2022/README.md) completed
- Make sure that the steps of [Prerequisites](https://github.com/Alliedium/springboot-api-rest-example/tree/master/.k8s#1-prerequisites)
are completed.

### Steps ###

Follow the steps of [Example 9](https://github.com/Alliedium/springboot-api-rest-example/tree/master/.k8s/09-metrics-view-via-grafana)
from `.k8s` folder of the project [Alliedium/springboot-api-rest-example](https://github.com/Alliedium/springboot-api-rest-example/).

### References ###

1. [Kubernetes explained in pictures: the theme park analogy](https://danlebrero.com/2018/07/09/kubernetes-explained-in-pictures-the-theme-park-analogy/)
2. [Kubernetes services, pods, ingress ... all the basic components](https://www.padok.fr/en/blog/kubernetes-essentials-components-pods-services)
3. [PostgreSQL Bitnami Helm Chart](https://github.com/bitnami/charts/tree/main/bitnami/postgresql)
4. [Values for PostgreSQL Bitnami Helm Chart](https://github.com/bitnami/charts/blob/master/bitnami/postgresql/values.yaml)
5. [PostgreSQL by Bitnami | Enable Metrics](https://docs.bitnami.com/kubernetes/infrastructure/postgresql/administration/enable-metrics/)
6. [Review: PostgreSQL Exporter](https://nexclipper.io/postgresql-exporter-review/)
7. [yq - a lightweight and portable command-line YAML, JSON and XML processor](https://github.com/mikefarah/yq#yq)
8. [Prometheus YAML on GitHub](https://github.com/prometheus/prometheus/blob/main/documentation/examples/prometheus-kubernetes.yml)
9. [Grafana Dashboards](https://grafana.com/grafana/dashboards/)
10. [Grafana Dashboards | PostgreSQL Database](https://grafana.com/grafana/dashboards/9628-postgresql-database/)
