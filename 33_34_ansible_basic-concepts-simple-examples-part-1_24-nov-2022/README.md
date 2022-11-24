## Ansible: basic concepts and simple examples, PART 1

### Prerequisites
All the examples that follow will assume that the following environment is configured.

There are at least 2 ways to create the environment: a) automanic and b) manual

#### Fully-automatic environment creation (Arch instead of Manjaro)

##### Provisioning
proxmox node: px-node-I
(NOTE: if named differently should be edited in .env files)

vnet created in SDN VLAN 3 zone on linux bridge vmbr0: v3
(LAN 3 should be set up in OpnSense according to the instruction provided at [lesson 29](https://github.com/Alliedium/devops-course-2022/tree/main/29_configuring_opnsense_and_creating_vms_via_scripts_and_manual_10_nov_2022))
---------------------------------------------------------------------------

* Get cloud-init scripts on proxmox node:
```
apt install git
git clone https://github.com/Alliedium/awesome-linux-config.git
```
If you already have the repository, make sure your version is the latest one:
```
cd ./awesome-linux-config
git pull
```
* SSH key must be placed here: /root/.ssh/id_rsa_cloudinit.pub

* Create resource pool:
  ```
  pvesh create /pools --poolid ansible-pool
  ```
* Go to the git directory you've cloned from git:
```
cd ./awesome-linux-config/proxmox7/cloud-init/
```
* Copy & edit (if necessary) .env.control (from this repository!)
* Apply env:
```
set -a; source ./.env.control; set +a
```
* Run image download:
```
./download-cloud-init-images.sh
```
* Run image customization:
```
./customize-cloud-init-images.sh
```
* Create ubuntu template:
```
./create-template.sh
```
* Create control node:
```
./create-vms.sh
```
* Copy & edit (if necessary) .env.ubuntu (from this repository!)
* Apply env:
```
set -a; source ./.env.ubuntu; set +a
```
* Create 2 ubuntu nodes:
```
./create-vms.sh
```
* Copy & edit (if necessary) .env.arch (from this repository!)
* Apply env:
```
set -a; source ./.env.arch; set +a
```
* Run image download:
```
./download-cloud-init-images.sh
```
* Create arch template:
```
./create-template.sh
```
* Create 2 arch nodes:
```
./create-vms.sh
```

#### Manual VM creation (Manjaro)
- Follow the Manjaro installation steps from [lesson 22](https://github.com/Alliedium/devops-course-2022/blob/main/22_networks_vlan_opnsense_vms_25-oct-2022/practice.md)
NOTE: Before converting the VM to template, run ssh-copy-id command from the proxmox node shell.
In order to be able to make it, first edit sshd_config file on your manjaro:
```
sudo nano /etc/ssh/sshd_config 
```
Make sure following parameters are not commented:
```
Port 22
PubkeyAuthentication yes
PasswordAuthentication yes
```
In case you had made any changes run:
```
sudo systemctl restart sshd
```
Then establish the connection from the node via ssh (you will be asked to enter password):
```
ssh <user>@<ip>
```
Then run ssh-copy-id as following (you will be asked to enter password):
```
ssh-copy-id -i ~/.ssh/id_rsa_cloudinit.pub <user>@<ip>
```
Now you are ready to convert the machine to template.

#### Get control node ready to set up ansible:

* Connect to control node.
* Get ansible scripts on control node:
```
git clone https://github.com/Alliedium/awesome-ansible.git
```
* Then follow the instructions:
```
cd ./awesome-ansible/README.md
```

## References on: Ansible

1. [Система управления Ansible](https://habr.com/ru/company/selectel/blog/196620/)
2. [Ansible documentation](https://docs.ansible.com/ansible/latest/)
3. [Automate EVERYTHING with Ansible! (Ansible for Beginners)](https://www.youtube.com/watch?v=w9eCU4bGgjQ)
4. [Getting started with Ansible](https://www.youtube.com/playlist?list=PLT98CRl2KxKEUHie1m24-wkyHpEsa4Y70)

