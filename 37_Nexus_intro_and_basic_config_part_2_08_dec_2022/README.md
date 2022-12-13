## Nexus intro and basic config part 2

Awesome Nexus configuration guide is available here: [awesome-nexus](https://github.com/Alliedium/awesome-nexus)

Covered topics: 

* How to run Nexus in as Docker container without docker-compose - updated commands available [here](https://github.com/Alliedium/awesome-nexus#run-nexus-as-a-docker-container)
* Which scheduled tasks should be setup in Nexus initially - additional info is [here](https://github.com/Alliedium/awesome-nexus#setup-cleanup-tasks-)

### Docker section: please refer to the [following part of awesome-nexus config](https://github.com/Alliedium/awesome-nexus#setup-docker-repositories) 
* How to setup properly Docker Proxy repository in Nexus
* What does HTTP connector means for Docker repositories in Nexus
* How to setup properly Docker Hosted repository in Nexus and what it is used for
* How to setup properly Docker Group repository in Nexus and what it is used for
* How to setup Docker tool in local system to interact with Nexus : `docker/daemon.json` file; how to close access to remote repos in `/etc/hosts`, why do we need to close access to remote repositories; `~/.docker/config.json` file checking
* How to create user roles and assign them to users in order to give limited access for contributing into particular Nexus repositories
* How to Pull from Docker-group repository and Push to Docker-hosted repository in Nexus with examples

### Helm section: please refer to the [following part of awesome-nexus config](https://github.com/Alliedium/awesome-nexus#setup-helm-repositories)
* How to setup properly Helm Proxy repository in Nexus and what it is used for
* How to setup properly Helm Hosted repository in Nexus and what it is used for
* How to use nelm-nexus-push addon for Nexus to push Helm charts avoiding curl


## Links for reference:

1. [docker/nexus3 container on Github](https://github.com/sonatype/docker-nexus3)
2. [sonatype/nexus3 container on Dockerhub](https://hub.docker.com/r/sonatype/nexus3/)
3. [helm-nexus-push addon for Nexus](https://github.com/Alliedium/helm-nexus-push)
4. [Change port mapping in docker container](https://stackoverflow.com/questions/19335444/how-do-i-assign-a-port-mapping-to-an-existing-docker-container)
5. [Bitnami.com stack with opensource versions of databases](https://bitnami.com/stacks/database)
6. [Using image Registries - k3d](https://k3d.io/v5.0.1/usage/registries/)
7. [containerd](https://containerd.io/)
8. [Advanced options and configuration - k3s](https://docs.k3s.io/advanced#configuring-containerd)