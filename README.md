# Awesome DevOps

Our free DevOps course is designed with a focus on Kubernetes and both on-prem and cloud solutions. We take an opinionated approach to teaching, providing you with the best practices and methodologies for working with these tools based on the experience of industry experts.

Our course is suitable for both beginners and experienced developers who are interested in gaining valuable skills and knowledge in DevOps. You'll learn how to streamline your development processes, deploy applications with ease, and scale your infrastructure to meet the demands of modern software development.

By the end of the course, you'll have a deep understanding of Kubernetes and how it can be used in both on-prem and cloud environments, giving you the skills you need to succeed in the tech industry.

The course has been organized into lessons, with dedicated folders for each lesson containing all relevant materials. Some of the lessons refer to materials and source code snippets from other repositories including

- https://github.com/Alliedium/awesome-devops
- https://github.com/Alliedium/awesome-kubernetes
- https://github.com/Alliedium/awesome-terraform
- https://github.com/Alliedium/awesome-ansible
- https://github.com/Alliedium/awesome-nexus
- https://github.com/Alliedium/awesome-nginx
- https://github.com/Alliedium/awesome-proxmox
- https://github.com/Alliedium/awesome-linux-config
- https://github.com/Alliedium/awesome-jenkins
- https://github.com/Alliedium/awesome-github-actions

We're excited to offer this free course to help you advance your career in tech!

## [01 DevOps introductory and virtualization 20220809](01_devops_introductory_virtualization_09-aug-2022)

- Virtualization: types, why to use
- Hypervisors: types, which to choose
- Proxmox: how does it work
- Demo: how to create a VM on Proxmox


## [02 Containers-1 20220811](02_containers_usage_basic_concepts_docker_part_1_11-aug-2022)

- What is a Container 
- Why did Containers appear
- Containers vs Virtual Machines
- How Containers are used
- Basic Concepts: Container Registry, Open Container Initiative, Container Engine, Container Runtime
- Docker tool


## [03 Virtualization On Windows And ZFS 20220816](03_virtualization_on_windows_and_zfs_11-aug-2022)

Virtualization On Windows
- Setting up virtualization in Windows
- Setting up nested virtualization for Windows
- Create Manjaro and Proxmox VMs in Hyper-V
- Install ssh and provide access from outside via ssh in Manjaro
- Disable password confirmation in Manjaro
- Setup free subscription in Proxmox

ZFS (Zettabyte file system)
- Hyper-V: create Manjaro and Proxmox VMs
- History, Advantages, Limitations
- Features: Pooled Storage, Copy-on-write, Snapshots


## [04a ZFS-2 20220818](04_virtualization_zfs_18-aug-2022)

ZFS Features
- Data integrity verification and automatic repair
- RAID handling
- Deduplication, Compression

Demo: creating zpool, dataset, snapshots, setting some zfs attributes


## [04b Containers-2 20220818](04b_containers_usage_basic_concepts_docker_part_2_18-aug-2022)

- What is a Dockerfile
- Difference between RUN and CMD commands in Dockerfile
- Client-server architecture
- Docker Desktop
- Kubernetes Cluster, master and worker nodes
- Container Runtime Interface (CRI) standard
- Podman tool
- Difference between Docker and Podman
- LXC tool


## [05 Docker Basic Commands, PostgreSQL in Docker 20220823](05_docker_basic_commands_postgres_23-aug-2022)

- Installing Git for Windows, mintty terminal, font installation in Windows for mintty terminal
- Managing images and containers
- Demo: run PostgreSQL in a container, connect via psql from host

## [06 ProxMox2 SSH backup 20220825](06_proxmox_lvm_resize_disk_ssh_access_backups_25-aug-2022)

- LVM Disk resize
- Setting access via SSH
- Backup and Restore

## [07 Docker Best Practices I: building Docker images, PgAdmin in Docker 20220830](07_docker_build_images_pgadmin_30-aug-2022)

- Dockerfile instructions
- Image parameterization
- Example 1: Simple Spring Boot application in a container with multi-stage build
- Example 2: pgAdmin in a container

## [08 Docker Best Practices II: multistage builds, different examples 20220906](08_docker_best_building_practices_06-sep-2022)

- Multistage builds
- Example 1: Simple Spring Boot application improved
- Example 2: Dockerfile of pytorch
- Example 3: Python dependencies in a separate image parameterized by hash
- Example 4: CMD vs ENTRYPOINT
- Example 5: Isolation of containers by user-defined network
- Example 6: Put ca-certificates into base image, parameterize the image by certificates hash

## [09 LVM Storage SSH Systemd cloud-init 20220908](09_proxmox_fstrim_cloudinit_ansible_lvm_08-sep-2022)

- LVM extends with additional PV
- Alternative to resize2fs for XFS
- Different Storage Types
- systemd: how to create your own service
- Timers for fstrim
- SSH ciphers
- Cloud-Init
- Proxmox Command Line
- Ansible
- Terraform

## [10 Network part 1 20220913](10_tcp-ip-model_switches_vlan_routers_protocols_13-sep-2022)

- Hosts
- IP Address, Network, Repeater, Hub, Bridge, Switch, Router
- OSI and TCP/IP model
- How packets move through a network
- Protocols

## [11 Kubernetes development basic tools 20220915](11_k8s_dev_tools_kubectl_krew_vscode_15-sep-2022)

Kubernetes deployment types
- in the cloud (EKS, AKS, GKE)
- prod-like on-prem / on bare metal (k0s, k3s, rke, rke2, kubespray, kubeadm, etc.)
- local (k3s, k3d, Kind, MicroK8S, Minikube, Docker Desktop, Rancher Desktop)

- Kubernetes development tools (k3d, kubectl + krew, vscode + plugin)
- Demo: managing clusters, contexts, namespaces. Running an app in a pod.

## [12 Network part 2 20220920](12_networks_dns_tls_https_encryption_20-sep-2022)

- Practice (_nmtui_, _nmcli_, arp, IP route)
- DNS (Root level domain, Top level domains, Second level domains, Recursive and Caching, Forwarding)
- TLS/SSL (what is, how protects data, CA)
- Hashing, Data integrity
- Encryption (asymmetric, symmetric; algorithms, public and private keys)
- How SSL/TLS uses Cryptography


## [13 Kubernetes development basic tools (ending), Kubernetes cluster contexts 20220922](13_k8s_dev_tools_openlens_k9s_22-sep-2022)

- Kubernetes development tools (code-server, k9s, openlens)
- Display Kubernetes current context in zsh command separator

## [14 Container orchestration Kubernetes basics: containers, pods, ephemeral volumes 20220927](14_k8s_pod_volume_27-sep-2022)

Deployment variants of Spring Boot Application with PostgerSQL database
- Example 1. Single pod with sidecar, ephemeral volume
- Example 2. Two pods, database in ephemeral volume

## [15 From network fundamentals to SDN implementation in Proxmox part 3 20220929](15_networks_dsa_ca_ssl_certificates_opnsense_29-sep-2022)

- Https, Certificates (DSA,CA, Cipher Suites, HSTS, SSL certificates, SSL termination, review OPNsense, pfsense, Vyos)
- Demo: Create and check self-signed certificate

## [16 Network part 4 20221004](16_networks_ssl_termination_self_signed_cert_04-oct-2022)

- Create VM in Proxmox
- Install and setup OPNsense
- Start python simple http server
- Update and install plugins in OPNsense
- Create self-sign certificate in OPNsense
- Configuring nginx Load Balancer for SSL termination with self-signed certificate

## [17 Network part 4-1 20221006](17_networks_ssl_termination_acme_route53_06-oct-2022)

- Create new account, users and domain in AWS
- Installing and configuring the ACME plugin in OPNsense for obtaining and renewing a SSL certificate
- Configuring the nginx plugin in OPNsense for SSL termination with public certificate, using ACME and Route53


## [18 Container orchestration Kubernetes basics 3 20221011](18_k8s_pvc_pv_svc_replicaset_liveness_readiness_11-oct-2022)

Deployment variants of Spring Boot Application with PostgerSQL database
- Example 3. Added services and persistence via PVC
- Example 4. ReplicaSets, Readiness and Liveness probes

## [19 Container orchestration Kubernetes basics 4 20221013](19_k8s_deployment_statefulset_configmap_secret_job_minio_13-oct-2022)

Deployment variants of Spring Boot Application with PostgerSQL database
- Example 5. Deployment, StatefulSet, ConfigMap, Secret

Backup jobs configuration variants
- Example 6. Simple job with Minio S3 storage

## [20 Container orchestration Kubernetes basics 5 20221018](20_k8s_cronjob_localstack_aws_s3_pgadmin_18-oct-2022)

Backup jobs configuration variants
- Example 7a. CronJob with Localstack AWS S3 Bucket
- Example 7b. CronJob with real AWS S3 Bucket

Installing useful tools in Kubernetes
- Example 8. Installing pgAdmin

## [21 Container orchestration Kubernetes basics 6 20221020](21_k8s_postgres_metrics_go_yq_prometheus_grafana_20-oct-2022)

Using already existing Helm charts and operators
- Example 9. Installing PostgreSQL with metrics view via Grafana

## [22 VLANs with examples part 1 20221025](22_networks_vlan_opnsense_vms_25-oct-2022)

- Network virtualization, VLANs
- Example: Proxmox cluster with three VLANs for VMs and separate VLAN for Proxmox nodes

## [23 VLANs with examples part 2 20221027](23_networks_vlan_nested_proxmox_cloud-init_27-oct-2022)

- Example: Proxmox cluster with three VLANs for VMs and separate VLAN for Proxmox nodes (ending)
- SDN VLAN setup
- Cloud-init scripts

## [24 VLANs with examples part 3 20221101](24_networks_vlan_inside_hyper_v_cloud-init_01-nov-2022)

- resolv.conf & netplan - correct network configuration setup on ubuntu
- Cloud-Init regenerate image & CLI
- SSH StrictHostKeyChecking
- Customize VMs via libguestfs-tools: virt-customize
- Example: Hyper-V with three VLANs for VMs and separate VLAN for Proxmox nodes

## [25 Kubernetes, PostgreSQL HA, Zelando Operator, part 1 20221101](25_k8s_postgresql_ha_zelando_operator_part_1_01-nov-2022)

- Operators and Custom Resource Definitions
- Adding nodes to k3d cluster
- Step 1 of Example 10. Installing scalable PostgreSQL via Kubernetes operator

## [26 Kubernetes, PostgreSQL HA, Zelando Operator, part 2 20221103](26_k8s_postgresql_ha_zelando_operator_part_2_03-nov-2022)

- CRDs and Custom Resources
- PostgreSQL High Availability
- How to create a Helm Chart from manifests
- Steps from 2 to 7 of Example 10. Installing scalable PostgreSQL via Kubernetes operator

## [27 Kubernetes, Anatomy of Helm charts 20221108](27_k8s_anatomy_of_helm_charts_08-nov-2022)

- Testing Helm chart
- Helm templates, template functions and pipelines
- Packaging Helm chart with versioning, upgrading Helm release to a new revision, rolling back to an old revision
- Installing PGAdmin4 via Helm chart
- Steps from 7 to 12 of Example 10. Installing scalable PostgreSQL via Kubernetes operator

## [28 Kubernetes, Setting up K3s prod-like: OPNsense template configuration, part 1 20221110](28_k8s_setting_up_k3s_prod_like_opnsense_template_configuration_part_1_10-nov-2022)

- Create new VM in Proxmox, install OPNsense with WAN network interface and convert VM to template

## [29 Kubernetes, Setting up K3s prod-like: Configuring OPNsense,  creating K3s nodes, part 2 20221110](29_k8s_setting_up_k3s_prod_like_configuring_opnsense_creating_k3s_nodes_part_2_10-nov-2022)

- Clone VM from opnsense-template, configuring OPNsense - adding firewall rules and setup Nginx - Load Balancer
- Create in Proxmox node VMs via Alliedium awesome-devops scripts
- Create VM manually in Proxmox node using cloud-init image
  
## [30 Kubernetes, Setting up K3s prod-like: Installing K3s via k3sup, part 3 20221115](30_k8s_setting_up_k3s_prod_like_installing_k3s_via_k3sup_part_3_15-nov-2022)

- Add IP route on router or workstation for 10.10.0.0 subnet
- Install k3sup on k3s-config VM
- Install k3s cluster via k3sup, in OpenLens open k3s cluster
- Add Longhorn repository and install longhorn chart in k3s cluster

## [31 Kubernetes, Setting up K3s prod-like: WSL2, iperf3, Hyper-V, part 4 20221117](31_k8s_setting_up_k3s_prod_like_wsl2_iperf3_hyper_v_part_4_17-nov-2022)

- Install WSL, chocolatey on Windows, kubectl, krew, ns, ctx, konfig, using konfig
- Kubernetes performance testing using kubernetes-iperf3
- Automatic upgrades/downgrades kubernetes cluster via k3s-Automated Upgrades
- Creating in Hyper-V vms via Hyper-V-Automation scripts, configure OPNsense network interface port as trunk

## [32 Kubernetes, Setting up k3s prod-like, still not production ready? part 5 20221122](32_k8s_setting_up_k3s_prod_like_still_not_prod_ready_part_5_22-nov-2022)

- SLA
- High Availability
- WAF
- Certificates
- Kubernetes garbage collection
- K8s distributions
- Hardening
- Load balancers and Ingress
- Cloud Native Ecosystem
- Persistent Storage
- Backups
- Private artifacts repositories
- Autoscaling

## [33 Ansible basic concepts & simple examples, part 1 20221124](33_ansible_basic_concepts_simple_examples_part_1_24-nov-2022)

- Install ansible
- Create inventory: hosts, groups, variables
- Commands: ansible-inventory, ansible, ansible-playbook
- Ansible tasks, gathering facts
- Ansible modules: ping, debug, apt, pacman, command
- Understanding privilege escalation: become
- Ansible conditionals
- Create training environment of several VMs within Proxmox node, both using cloud-init (Ubuntu, Arch)


## [34 Ansible basic concepts & simple examples, part 2 20221129](34_ansible_basic_concepts_simple_examples_part_2_29-nov-2022)

- Create training environment of several VMs within Proxmox node, both using cloud-init (Ubuntu, Arch) & manually (Manjaro)
- Configuring and establishing SSH connection 
- Installing packages depending on host type: package, cloud_init_data_facts and stat modules
- Debugger for ansible playbooks
- Registering new variables in playbook, return values
- Variables in inventory, templates in tasks, hostname module
- Regular expressions, replace module

## [35 Nexus intro and basic config, part 1 20221201](35_Nexus_intro_and_basic_config_part_1_01-dec-2022)

- Learned about Nexus analogues (Amazon ECR, Harbor, Chartmuseum, local Arch linux repo)   
- Covered Installation methods: via package manager, manual, docker, kubernetes
- Backup and restore of Nexus instance
- Post-install steps: Nexus directories, anonymous access & local authorizing realm,  setup and applying cleanup policies, Cleanup tasks setup

## [36 Ansible basic concepts & simple examples, part 3 20221206](36_ansible_basic_concepts_simple_examples_part_3_06-dec-2022)

- Using group_vars and host_vars, variables' precedence
- Asking for sudo password: -K/--ask-sudo-pass argument for ansible-playbook command
- wait_for_connection module
- Command module
- Why do we need qemu-guest-agent
- What is snapd and why we get rid of it
- What is a role in Ansible
- Installing a role from ansible-galaxy (GitHub, GitLab)
- Installing multiple roles using requirements.yml
- Using roles in playbooks
- What is an NTP server
- Converting bash scripts into ansible playbooks
- Editing sudoers
- Package module
- What is yay

## [37 Nexus Docker and Helm repo config, part 2 20221208](37_Nexus_intro_and_basic_config_part_2_08-dec-2022)

- How to run Nexus in as Docker container without docker-compose
- Which scheduled tasks should be setup in Nexus initially
- How to set up properly Docker Proxy repository in Nexus
- What does HTTP connector means for Docker repositories in Nexus
- How to set up properly Docker Hosted repository in Nexus and what it is used for
- How to set up properly Docker Group repository in Nexus and what it is used for
- How to set up Docker tool in local system to interact with Nexus 
- How to create user roles and assign them to users in order to give limited access for contributing into particular Nexus repositories
- How to Pull from Docker-group repository and Push to Docker-hosted repository in Nexus with examples
- How to check Nexus logs (if it's up in Docker)
- How to inspect and cleanup system via ncdu
- How to set up Kubernetes cluster to refer to Nexus docker images (k3s configuration, k3d configuration)
- How to interact with containerd images via crictl
- How to set up properly Helm Proxy repository in Nexus and what it is used for
- How to set up properly Helm Hosted repository in Nexus and what it is used for
- How to use nelm-nexus-push addon for Nexus to push Helm charts avoiding curl

## [38 Automation of K3s cluster provisioning via Ansible: VyOS intro, part 1 20221213](38_setting_up_production_like_kubernetes_cluster_part_3_13-dec-2022)

- Installing and configuring VyOS VM manually
  
## [39 Automation of K3s cluster provisioning via Ansible: VyOS configuration, K3s Ansible project, part 2 20221214](39_setting_up_production_like_kubernetes_cluster_part_4_14-dec-2022)

- Installing and configuring VyOS VM manually
- Demonstration of firewall ruleset in Linux using nft command line tool
- Creating of VyOS cloud-init image via Ansible playbook
- Creating of configured VyOS VM on Proxmox node using Ansible playbook

## [40 Automation of K3s cluster provisioning via Ansible: kube-vip, MetalLB, K3s Ansible project, part 3 20221215](40_setting_up_production_like_kubernetes_cluster_part_5_15-dec-2022)

- Changing of VyOS firewall configuration
- What is kube-vip and how it works
- What is MetalLB and how it works
- Installing K3s cluster via Ansible playbook (including kube-vip and MetalLB)
- Creating pod and services to expose pod
- Changing MetalLB IP address range in manifest in OpenLens

## [41 Nexus: Maven, Gradle, Conda, pip, poetry, APT, Ansible repo config, part 3 20221216](41_Nexus_intro_and_basic_config_part_3_16-dec-2022)

- How to set up Maven Proxy, Maven Hosted and Maven Group repositories in Nexus
- How to configure settings.xml and pom.xml so that Maven can refer to Nexus repositories
- How to configure Gradle to use Nexus Maven repositories
- How to set up Conda Proxy repository in Nexus
- What is Conda environments, how to use them
- How to configure Conda-based tools (e.g. Micromamba) to use Nexus Proxy repository
- How to set up npm Proxy, npm Hosted and npm Group repositories in Nexus
- How to configure npm client to use Nexus - pull and push examples
- How to workaround npm audit calls
- How to set up PyPI Proxy, PyPI Hosted and PyPI Group repositories in Nexus
- How to configure pip (and other tools e.g. twine) to use Nexus
- How to package Python project before pushing
- What is Realworld projects
- How to set up APT Proxy and APT Hosted repositories in Nexus
- How to configure client side to use APT repositories from Nexus
- How to add Ansible format to list of supported formats in Nexus
- How to add S3 blobstore to Nexus

## [42 Ansible: advanced concepts, part 4 20221220](42_ansible_advanced_concepts-part_4_20-dec-2022)

- Manjaro basic bash scripts
- Making Ansible playbooks working more stable: wait_for_connection, stat modules
- Collecting facts about packages: package_facts module
- What is the Sudoers File and how to modify it via Ansible: sudoers module
- What is AUR, pacman and yay, how to install and use yay on Arch Linux, what is pamac
- Task conditional expressions - Jinja Tests
- How to remove files and directories in Ansible: file module
- Task loops
- Understanding privilege escalation: become
- How to avoid entering sudo password, sudoers syntax
- Ansible roles
- What is Ansible collections, aur - collection including an Ansible module to manage packages from the AUR
- Avoiding copy-pasting I - defining variables in playbook runtime: set_fact module
- Playbook handlers, the execution order of tasks, roles and handlers
- Defining default values for variables, once again variable precedence
- How to run a role multiple times in one play
- Avoiding copy-pasting II - using blocks
- Useful Ansible modules: git, replace, lineinfile, ansible.posix.sysctl
- Makepkg - utilizing multiple cores on compression
- Templating (Jinja2), using filters to manipulate data
- How to install and configure latest version of Ansible on Ubuntu Linux
- Ansible plays
- Task tags
- Testing Ansible playbooks

## [43 Ansible: advanced concepts, part 5 20221222](43_ansible_advanced_concepts_part_5_22-dec-2022)

- Install multiple collections with a requirements file
- Useful Ansible modules I: template, systemd
- Using roles at the play level, pre_tasks and post_tasks
- Using Ansible roles within tasks: include and import
- Manjaro basic bash scripts for users executed by sysadmin and by users
- Managing users and groups in Ansible: getent and user modules
- Difference between include and import for roles: looping for include, attribute inheritance for import
- Becoming a different user in Ansible
- Userful Ansible modules II: git_config, file, copy, find, get_url modules
- Ansible linter
- Testing Ansible playbooks and roles: Molecule, setup testing on github repository, install Molecule on Manjaro, run local test, debug test, cleanup test result 
- Comparing: bash scripts, Ansible, terraform, crossplane and cdk

## [44 Ansible internals of k3s ansible role, 20230207](44_ansible_internals_of_k3s_ansible_role_07-feb-2023)

- A brief overview of the topics of the first part of the DevOps course
- Explain k3s Ansible role, part 1
- Types of nodes in the `k3d` and `k3s` cluster
- Kube-vip
- Extra parameters for k3s master node
- metallb ip range
- k3s releases
- k3s-init, k3s services, daemon reload

## [45 Ansible internals of k3s ansible role and Vyos, 20230209](45_ansible_internals_of_k3s_ansible_and_vyos_provisioning_role_09-feb-2023)

- Explain k3s Ansible role, part 2
- Stop and disable k3s, k3s-node, k3s-init services
- set -o pipefail command
- Explain Vyos Ansible role
- Show configuration commands
- Generate password for new vyos user
- Proxmox_kvm module

## [46 Awesome NGINX, part 1 20230214](46_awesome_nginx_part_1_14-feb-2023)
This lesson is a brief tutorial on using NGINX, a popular web server, for various use cases, such as setting up a single static page, virtual hosting with static pages, and HTTP load balancing. It includes links to relevant documentation, prerequisites to set up NGINX, and step-by-step instructions for each use case.

Key subjects:

- NGINX
- Reverse Proxy
- Load Balancer
- TLS
- SNI Routing
- Docker
- Virtual Hosting
- Static Pages
- HTTP
- HTTPS
- NGINX-Demos
- Web Server
- Self-signed certificate
- DNS
- IP subnet
- w3m

## [47 Awesome NGINX, part 2 20230216](47_awesome_nginx_part_2_16-feb-2023)

This lesson provides a set of instructions to run HTTP backend servers with Virtual Hosting, Terminate TLS, and no HTTP routing using Nginx. The instructions are given in the form of a script that the user needs to run, which generates two self-signed certificates and configures Nginx to make it extract the server_name from the certificates and compare it with the client certification.

The instructions involve several commands, such as running HTTP backend servers, generating self-signed certificates, studying new Nginx configuration, and applying the new configuration. Moreover, it describes how to check that the reverse proxy works as expected and how to fix permission for Nginx private keys.

The lesson has covered a few key subjects including Nginx, Virtual Hosting, TLS, HTTP routing, backend servers, self-signed certificates, server_name, ssl_preread_server_name, map block, stream block, reverse proxy, private keys, root permissions, child process, and http user.

Key subjects:

- NGINX
- Stream, map
- ssl_preread
- tls-termination
- File access in Linux
- Issue a self-signed SSL certificate
- nginx.service
- nginx -t, nginx -T
- w3m, lsof

## [48 Provisioning Nexus via Ansible playbook 20230221](48_provisioning_nexus_via_ansible_22-feb-2022)

This lesson show how to install and configure Nexus (NXRM - Nexus Repository Manager)  using Ansible playbook

Key subjects:

- Nexus
- anonymous access the server
- roles
- local users
- repos cleanup policies
- scheduled tasks
- cron
- index type
- nexus certificates to access index

## [49 Advanced backing up of infrastructure in Proxmox, 20230223](49_advanced_backing_up_of_infrastruture_in_proxmox_23-feb-2023)

- Proxmox Backup Server
- Installing
- Configuration Proxmox Backup Server
- Configuration in Proxmox

## [50 Proxmox advanced, email notifications, shared-storage, part1, 20230228](50_proxmox_advanced_email_notifications_shared_storage_part_1_28-feb-2023)

- SSH known_hosts file
- email notifications
- postfix
- Ansible postfix role, Ansible-vault
- Storage Types

## [51 Proxmox advanced, email notifications, shared storage, part 2, 20230302](51_proxmox_advanced_email_notifications_shared_storage_part_2_02-mar-2023)

- Storing and using the Ansible vault password in a file
- Setting up NFS share storage on ZFS
- Add NFS storage in Proxmox
- Move VM HDD disk to NFS shared storage
- Testing the speed of writing/reading a file in NFS shared storage and on VM
- Migrate VM to another `Proxmox` node

## [52 Amazon NGINX, part 3 20230307](52_amazon-nginx-part_3_07-mar-2023)

- setting iptables
- Proxmox firewall
- Virtual hosting with LetsEncrypt TLS certificate generated by certbot with HTTP-01 challenge, certbot-nginx
- renew certificate
- certificate renew automation via crontab
- dns-route53 plugin

## [53 Amazon NGINX, part 4 20230309](53_amazon-nginx-part_4_09-mar-2023)

- certificate renew automation via certbot-dns-route53
- basic certbot commands: get certificates, delete certificates, certonly
- create IAM user in Amazon for programmatic access for certbot-dns-route53 plugin
- the local setting of aws-client credentials
- aws-cli and aws-cli-v2 packages
- restart and reload nginx.service command
- certbot built-in timer certbot-renew.timer in the systemd
- --post-hook "systemctl reload nginx.service"

## [54 Kubernetes, Ingress controller, part 1 20230309](54_k8s_ingress_part_1_09-mar-2023)

- Installing and Uninstalling NGINX Ingress Controller via Helm with setting the IP address of the loadbalancer 
- helm install and helm upgrade commands, --cleanup-on-fail flag
- create Ingresses for backends and access backends 

## [68 CI/CD, Jenkins, part 1 20230516](68_ci_cd_jenkins_part_1_16-may-2023)

- CI/CD, git-flow, git-ops conceptions
- review CI/CD tools
- artifacts
- github actins
- Jenkins tool
- server, agent, plugins, pipeline, build, multibranch-pipeline
- Jenkins configuration
- Ansible playbook
  
## [69 CI/CD, Jenkins, part 2 20230518](69_ci_cd_jenkins_part_2_18-may-2023)

- installing Jenkins with plugins via Ansible playbook 
- LTS and weekly Jenkins versions
- pipeline script
- environment variables and parameters in Jenkins
- maven, pom.xml, profile, static-code-analysis, lifecycles
- checkstyle and suppressions configuration in pipeline script
- reports, workspace
- Jenkins job configuration in Ansible playbook

## [70 CI/CD, Jenkins, part 3 20230525](70_ci_cd_jenkins_part_3_25-may-2023)

- Ansible tags, jenkins_script, jenkins_job and jenkins_job_info Ansible modules
- Ansible playbook testing with molecule
- Ansible playbook testing with github Actions
  
## [71 CI/CD, Jenkins, part 4 20230530](71_ci_cd_jenkins_part_4_30-may-2023)

- Jenkins and GitHub integration
- GitHub: Organizations, app, app permissions, app private key, Checks
- Jenkins multibranch pipeline configuration

## [74 CI/CD, GitHubActions, Runners 20230620](74_ci_cd_github_actions_runners_20-jun-2023)

- Runners in GitHub Actions
- Adding self-hosted runners (Linux, Windows and docker) to a repository
- Mapping self-hosted runners with jobs via labels
- Debugging workflow jobs, tmate
- Remove self-hosted runner