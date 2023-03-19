# Explain k3s `Ansible` playbook

### In our [40 lesson](../40_setting_up_production_like_kubernetes_cluster_part_5_15_dec_2022#install-k3s-cluster-via-ansible-playbook-on-vms) we have shown as run k3s `Ansible` playbook in [`Install k3s cluster via ansible playbook on VMs`](../40_setting_up_production_like_kubernetes_cluster_part_5_15_dec_2022/README.md) section.

In this tutorial we explained how [k3s `Ansible` playbook](https://github.com/techno-tim/k3s-ansible) works. When starting the `Ansible` playbook, as an example, we used the following [scheme](./images/Scheme_1.png).

  - ![scheme](./images/Scheme_1.png)

      * `Ansible-controller`  - workstation on which we run the `Ansible` playbook
      * `k3s-node-x` - these are the VMs on which we install `k3s` cluster 
  
  * In our example we installed 3 `masters` and 1 `node` of `k3s` cluster nodes, but you can install any number of `k3s` nodes. It is recommended to install at least 3 `master` `k3s` nodes. 
  * `Ansible-controller` should have `ssh` access to `k3s-node-x` VMs, VMs must have a network connection between themselves. Your can create in `Proxmox` all VMs using our [scripts](https://github.com/Alliedium/awesome-linux-config).

  * Before you start playbook see [System requirements](https://github.com/techno-tim/k3s-ansible#-system-requirements) section.
  * How to install latest `Ansible` version on `Debian` or `Ubuntu` see [Install the latest version of Ansible](https://github.com/Alliedium/awesome-ansible#setting-up-config-machine) section.

  * `Inventary` was discussed in [33 lesson](../33_ansible_basic-concepts-simple-examples-part-1_24-nov-2022#ansible-basic-concepts-and-simple-examples-part-1).
  * `Ansible` vars precedence was explained in [36 lesson](../36_ansible_basic-concepts-simple-examples-part-3_06-dec-2022/README.md).
  * `VIP` and `metallb` - [40 lesson](../40_setting_up_production_like_kubernetes_cluster_part_5_15_dec_2022#7-show-how-metallb-loadbalancer-work).
  * `ssh-keygen` - [6](../06_proxmox_lvm_resize_disk_ssh_access_backups_25-aug-2022#using-ssh-agent) and [29 lessons](../29_kubernetes_setting_up_k3s_prod_like_configuring_opnsense_creating_k3s_nodes_part_2-10_nov_2022#3-on-your-workstation-in-terminal-generate-ssh-keys).
  * `Systemd` - [9 lesson](../09_proxmox_fstrim_cloudinit_ansible_lvm_08-sep-2022/README.md).

# References on #

1. [Alliedium/awesome-devops](https://github.com/Alliedium/awesome-devops)
2. [Alliedium/awesome-kubernetes](https://github.com/Alliedium/awesome-kubernetes/tree/main)
3. [Alliedium/awesome-ansible](https://github.com/Alliedium/awesome-ansible)
4. [Alliedium/awesome-nexus](https://github.com/Alliedium/awesome-nexus)
5. [DevOps training on elearning](https://elearning.alliedtesting.com/course/view.php?id=107)
6. [techno-tim/k3s-ansible](https://github.com/techno-tim/k3s-ansible)
7. [Install the latest version of Ansible](https://github.com/Alliedium/awesome-ansible)
8. [Diagram k3d](https://www.sokube.ch/post/k3s-k3d-k8s-a-new-perfect-match-for-dev-and-test)
9.  [kube-vip](https://kube-vip.io/)
10. [Kube-vip](https://www.youtube.com/watch?v=JvDjQLrAGSY)
11. [k3s-io/k3s - releases](https://github.com/k3s-io/k3s/releases)
12. [Say good-bye to HAProxy and Keepalived with kube-vip on your HA K8s control plane](https://inductor.medium.com/say-good-bye-to-haproxy-and-keepalived-with-kube-vip-on-your-ha-k8s-control-plane-bb7237eca9fc)
13. [Linux configuration: Understanding *.d directories in /etc](https://www.redhat.com/sysadmin/etc-configuration-directories)
14. [CONFIGURATION DIRECTORIES AND PRECEDENCE](https://man7.org/linux/man-pages/man5/sysctl.d.5.html)
15. [set -e, -u, -x, -o pipefail](https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425)