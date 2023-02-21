# Provisioning Nexus via Ansible

This tutorial show how to install and configure Nexus (NXRM - Nexus Repository Manager)  using Ansible playbook. [ansible-ThoTeam/nexus3-oss](https://github.com/ansible-ThoTeam/nexus3-oss) was used as a basis. 

In lessons 35, 37 and 41 it was shown how to install and configure `Nexus`.

## Prerequisites:

- Use [awesome-nexus/ansible/](https://github.com/Alliedium/awesome-nexus/tree/main/ansible) ansible playbook to install and configure the `Nexus`
- Create virtual machine on which we will install and configure the `Nexus`. We used `Ubuntu` Linux distribution. 
- Follow [Prerequisites](https://github.com/Alliedium/awesome-nexus/tree/main/ansible#prerequisites) steps.

## Install Nexus via playbook

- Clone Ansible playbook
  
  ```
  git clone https://github.com/Alliedium/awesome-nexus.git $HOME/awesome-nexus
  cd $HOME/awesome-nexus/ansible

  ```

- Follow [Install Nexus via playbook](https://github.com/Alliedium/awesome-nexus/tree/main/ansible#install-nexus-via-playbook) steps to run playbook.

## References

1. [sonatype | DOCUMENTATION](https://help.sonatype.com/repomanager3/installation-and-upgrades/directories)
2. [Sonatype Nexus Repository Open Source Codebase](https://github.com/sonatype/nexus-public)
3. [User Authentication](https://help.sonatype.com/repomanager3/nexus-repository-administration/user-authentication)
4. [cron-expressions](https://www.elastic.co/guide/en/elasticsearch/reference/7.17/cron-expressions.html)
5. [Deployment Policy](https://help.sonatype.com/repomanager2/configuration/managing-repositories)
6. [Version policy/Layout policy](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/maven-repositories)
7. [MIME type](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types)
8. [Docker Index](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/docker-registry/proxy-repository-for-docker?_ga=2.188474912.920986931.1676902935-1817685507.1675672181)
8. [Docker Index](https://github.com/docker/cli/issues/3793#issuecomment-1269051403)
9. [Apt Repositories](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/apt-repositories?_ga=2.264627719.920986931.1676902935-1817685507.1675672181)
10. [Flat Repository Format](https://wiki.debian.org/DebianRepository/Format#Flat_Repository_Format)
11. [Foreign Layers](https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/docker-registry/foreign-layers)
12. [Outbound SSL, Trusting SSL Certificates of Remote Repositories](https://help.sonatype.com/repomanager3/nexus-repository-administration/configuring-ssl?_ga=2.20170544.920986931.1676902935-1817685507.1675672181)
