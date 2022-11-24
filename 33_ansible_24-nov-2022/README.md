## Practice --- How to automate machines setup via Ansible - training environment setup

Prerequisites:

proxmox node: px-node-I
set up linux bridge: vmbr1

---------------------------------------------------------------------------

* Get cloud-init scripts on proxmox node:
```
apt install git
git clone https://github.com/Alliedium/awesome-linux-config.git
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
* Connect to control node.
* Get ansible scripts on control node:
```
git clone https://github.com/Alliedium/awesome-ansible.git
```
* Then follow the instructions:
```
cd ./awesome-ansible/README.md
```


