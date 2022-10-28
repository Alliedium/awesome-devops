# VM provisioning scripts based on Cloud Init images

## 1. Login to one of the nodes of your proxmox cluster
- Use either ssh or "Shell" in PVE Web UI

## 2. Clone this repo and cd to this folder
- Install git if missing: `apt install git`
- Clone the repo: `git clone https://github.com/Alliedium/awesome-linux-config.git`
- Change you current directory: `cd ./awesome-linux-config/proxmox7/cloud-init`
## 3. Copy the configuration and adjust it to match your case 
- Create your own env file using the provided example: `cp ./.env.example ./.env`
- Adjust the parameters (with self-explanatory names) inside `./.env` to match your PVE configuration.
## 4. Export variables from your configuration
 - Export environment variables from your env file: `set -a; source ./.env; set +a`
## 5. Download cloud init images
- `./download-cloud-init-images.sh` 
## 6. Create VM template
- `./create-template.sh`
## 7. Clone VMs across different nodes
- `./create-vms.sh`
## 8. Start all the cloned VMs
- `./start-stop-vms.sh start`

## 9. Stop all the cloned VMs (Optional)
- `./start-stop-vms.sh stop`

## 10. Destroy all the cloned VMs (Optional) 
- `./destroy-vms.sh`

## 11. Destroy the VM template (Optional)
- `./destroy-template.sh`

# Batch commands
## 1. Create the template, create and start VMs
```
./batch-create-start.sh
```

## 2. Stop and destroy the VMs, then destroy the template

```
./batch-stop-destroy.sh
```
# Tests
- `./test-happy-path-granular.sh` - this test basically performs the full cycle of VM creation and destruction.
- `./test-happy-path-batch.sh` - this test verifies batch scripts.
# Other OSS Proxmox tools
The scripts above are intended for creating 1 standard VM on every PVE. This can have many application, setting up VMs for K8s Cluster is one of them. 
If you are interested in automation for PVE - have a look at

 - https://github.com/marrobHD/proxmox-tools
 - https://github.com/Corsinvest/cv4pve-cli
 - https://github.com/Tontonjo/proxmox_toolbox
 - https://github.com/tteck/Proxmox
 - https://github.com/Telmate/terraform-provider-proxmox
