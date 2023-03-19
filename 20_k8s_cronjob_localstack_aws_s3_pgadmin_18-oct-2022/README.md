## Container orchestration, Kubernetes basics, part 5, 18 Oct 2022

### Prerequisites ###

- The following commands were executed on VM with [Manjaro Linux distribution](https://manjaro.org/download/) (however, they might be performed on another Linux distribution, but the command might differ, e.g. another package manager etc.)
- Docker installed (see [Lesson 5 prerequisites](../05_docker_basic_commands_postgres_23-aug-2022/README.md))
- k3d cluster created and set up as per steps of [Lesson 11](../11_k8s_dev_tools_kubectl_krew_vscode_15-sep-2022/README.md) completed
- Make sure that the steps of [Prerequisites](https://github.com/Alliedium/awesome-kubernetes/tree/main#prerequisites) 
and [Example 5](https://github.com/Alliedium/awesome-kubernetes/tree/main/05-deployment-statefulset-configmap-secret) 
are completed.

### Steps ###

Follow the steps of [Example 7](https://github.com/Alliedium/awesome-kubernetes/tree/main/07-cronjob-with-aws-s3)
and [Example 8](https://github.com/Alliedium/awesome-kubernetes/tree/main/08-pgadmin) 
from [Alliedium/awesome-kubernetes](https://github.com/Alliedium/awesome-kubernetes/).

### References ###

1. [Kubernetes explained in pictures: the theme park analogy](https://danlebrero.com/2018/07/09/kubernetes-explained-in-pictures-the-theme-park-analogy/)
2. [Kubernetes services, pods, ingress ... all the basic components](https://www.padok.fr/en/blog/kubernetes-essentials-components-pods-services)
3. [Kubernetes | Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
4. [Kubernetes | Automatic Clean-up for Finished Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/ttlafterfinished/)
5. [Kubernetes | CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
6. [tiredofit/docker-db-backup - a container for backing up multiple types of DB Servers](https://github.com/tiredofit/docker-db-backup)
7. [AWS account](https://aws.amazon.com/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc)
8. [How do I create and activate a new AWS account?](https://aws.amazon.com/ru/premiumsupport/knowledge-center/create-and-activate-aws-account/)
9. [Creating an IAM user in your AWS account](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)
10. [AWS CLI functions in ohmyzsh](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/aws/aws.plugin.zsh)
11. [pgAdmin](https://www.pgadmin.org/)
12. [pgAdmin 4 (Container)](https://www.pgadmin.org/download/pgadmin-4-container/)
13. [pgadmin4 by dpage on Docker Hub](https://hub.docker.com/r/dpage/pgadmin4)
