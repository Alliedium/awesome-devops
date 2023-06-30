## Nexus intro and basic config part 2

Awesome Nexus configuration guide is available here: [awesome-nexus](https://github.com/Alliedium/awesome-nexus)

Covered topics: 

* How to run [Nexus as Docker container](https://github.com/Alliedium/awesome-nexus#run-nexus-as-a-docker-container) without docker-compose
* Which [scheduled tasks](https://github.com/Alliedium/awesome-nexus#setup-cleanup-tasks-) should be setup in Nexus initially

### [Docker section](https://github.com/Alliedium/awesome-nexus#setup-docker-repositories) 
* How to setup properly Docker Proxy repository in Nexus
* What does HTTP connector means for Docker repositories in Nexus
* How to setup properly Docker Hosted repository in Nexus and what it is used for
* How to setup properly Docker Group repository in Nexus and what it is used for
* How to setup Docker tool in local system to interact with Nexus : `docker/daemon.json` file; how to close access to remote repos in `/etc/hosts`, why do we need to close access to remote repositories; `~/.docker/config.json` file checking
* How to create user roles and assign them to users in order to give limited access for contributing into particular Nexus repositories
* How to Pull from Docker-group repository and Push to Docker-hosted repository in Nexus with examples

### [K3d and K3s configuration](https://github.com/Alliedium/awesome-nexus#configure-k3s-cluster-to-use-nexus-docker-repositories)
* How to configure K3d clusters to use Nexus Docker repositories
* How to debug nodes, verify the configurations and work with images from local registries on nodes
* How to make the same for K3s clusters in general

### [Helm section](https://github.com/Alliedium/awesome-nexus#setup-helm-repositories)
* How to setup properly Helm Proxy repository in Nexus and what it is used for
* How to setup properly Helm Hosted repository in Nexus and what it is used for
* How to use nelm-nexus-push addon for Nexus to push Helm charts avoiding curl


## Links for reference:

1. [docker/nexus3 container on Github](https://github.com/sonatype/docker-nexus3)
2. [sonatype/nexus3 container on Dockerhub](https://hub.docker.com/r/sonatype/nexus3/)
3. [helm-nexus-push addon for Nexus](https://github.com/Alliedium/helm-nexus-push)
4. [Change port mapping in docker container](https://stackoverflow.com/questions/19335444/how-do-i-assign-a-port-mapping-to-an-existing-docker-container)
5. [Bitnami.com stack with opensource versions of databases](https://bitnami.com/stacks/database)
6. [Private Registry Configurations - k3s](https://docs.k3s.io/installation/private-registry)
7. [Using Image Registries - k3d](https://k3d.io/v5.4.6/usage/registries/)
8. [Using Config Files - k3d](https://k3d.io/v5.4.6/usage/configfile/)
9. [containerd](https://containerd.io/)
10. [Advanced options and configuration - k3s](https://docs.k3s.io/advanced#configuring-containerd)
11. [How to access services (like a database) running on my Docker Host Machine - `host.k3d.internal` - k3d](https://k3d.io/v5.4.6/faq/faq/#how-to-access-services-like-a-database-running-on-my-docker-host-machine)
12. [Install Lens – Best Kubernetes Dashboard & IDE](https://computingforgeeks.com/install-lens-best-kubernetes-dashboard/)
13. [kubectl-node-shell](https://github.com/kvaps/kubectl-node-shell)
14. [Debugging Kubernetes nodes with crictl](https://kubernetes.io/docs/tasks/debug/debug-cluster/crictl/)
15. [Why and How to Use containerd From Command Line](https://iximiuz.com/en/posts/containerd-command-line-clients/)
