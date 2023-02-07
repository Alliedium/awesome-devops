## Ansible simple example demo ## 

### Prerequisites: ###

The following commands were executed on VM with [Rocky 8 Linux distribution](https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.7-x86_64-minimal.iso) (however, almost the same commands might be performed on a machine with other Linux distribution OS).
See the general instructions on VM creation & OS installation in [Lesson 1](../01-devops_introductory_virtualization_09-aug-2022/README.md).

1. Ansible should be installed on the control VM (where the playbooks will be run).

```
sudo dnf install epel-release
sudo dnf install ansible
```

2. The playbook is placed in the following directory:

```
cat $HOME/devops-course-2022/ansible/playbooks/change-hostnames.yml
```

3. The SSH key to managed machines should be placed in .ssh directory:

```
cat ~/.ssh/id_rsa_cloudinit
```

### Steps: ###

A hosts.ini file is necessary to specify the IP addresses of the hosts supposed to get affected by the playbook. 
The file is placed into subdirectory named cloudinit-vms. 
Replace `<ip-1>`, ... , `<ip-N>` by IP addresses of your VMs in the command below:
```
cat <<EOF > $HOME/devops-course-2022/ansible/inventory/cloudinit-vms/hosts.ini
<ip-1>
<ip-2>
...
<ip-N>
EOF
```

Once the IPs and the preferable hostnames are specified, ssh-agent has to be enabled:
```
eval `ssh-agent`
ssh-add ~/.ssh/id_rsa_cloudinit
```

Then run the playbook:
```
ansible-playbook -i ./inventory/cloudinit-vms/hosts.ini -v ./playbooks/change-hostnames.yml
```

In case info about roles is necessary:
```
ansible-galaxy role --help
```

To install a new role:
```
ansible-galaxy role install bodsch.snapd
```
The role should appear in the list:
```
ansible-galaxy role list
```

