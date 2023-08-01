# Alliedium DevOps course 2022-2023

# Jenkins part 1
Here we will install Jenkins server by means of the ansible playbook (to be continued before review)
## Prerequisites for your local machine
1. Ubuntu linux Jammy. To install You can follow instructions from the [link](https://github.com/Alliedium/awesome-ansible#2-general-notes-on-creating-your-own-custom-inventory-and-playbooks) to install Ubuntu linux
2. Ansible. Please follow the step 2 of the [instructions](https://github.com/Alliedium/awesome-ansible#2-general-notes-on-creating-your-own-custom-inventory-and-playbooks)
3. Install openJdk-17
   `sudo apt update`
   `sudo apt upgrade`
   `sudo apt install -y openjdk-17-jdk`
4. If you have more than one java version, check current java version
   `java --version`
   If it is not the 17, list installed versions
   `sudo update-java-alternatives -l`
   And checkout to the 17 version
   `sudo update-java-alternatives -s java-1.17.0-openjdk-amd64`

5. Clone project ansible-jenkins:
   `git clone https://github.com/Alliedium/awesome-jenkins.git`

6. Follow the instructions from [link](https://github.com/Alliedium/awesome-jenkins/blob/ALM-2030_install_jenkins_and_create_job/README.md)

### References:
   1. [Videos about CI/CD and Jenkins](https://www.youtube.com/watch?v=pMO26j2OUME&list=PLy7NrYWoggjw_LIiDK1LXdNN82uYuuuiC)
   2. [Multibranchpipelines](https://www.jenkins.io/doc/book/pipeline/multibranch/) 
