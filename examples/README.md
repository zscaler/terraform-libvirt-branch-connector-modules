# Zscaler Branch Connector Cluster Infrastructure Setup

**Terraform configurations and modules for deploying Zscaler Branch Connector Cluster in KVM.**

## Prerequisites (You will be prompted for KVM connection URI details during deployment)

### KVM requirements
1. A valid connection URI to connect to the KVM hypervisor. For full more information on connection URI methods, click [here.](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs)

Note:<br>
On Ubuntu distros SELinux is enforced by qemu even if it is disabled globally, this might cause unexpected `Could not open '/var/lib/libvirt/images/<FILE_NAME>': Permission denied` errors. Double check that `security_driver = "none"` is uncommented in `/etc/libvirt/qemu.conf` and issue `sudo systemctl restart libvirt-bin` to restart the daemon.<br>

### Terraform client requirements
2. If executing Terraform via the "zsec" wrapper bash script, it is advised that you run from a MacOS or Linux workstation. Minimum installed application requirements to successfully from the script are:
- bash
- curl
- unzip
<br>
<br>
Even if you are running Terraform manually, there are still the following local application dependencies for the libvirt Terraform provider:
- mkisofs
- xsltproc
<br>
<br>
These can all be installed via your distribution app installer. ie: sudo apt install bash curl unzip mkisofs xsltproc

### Zscaler requirements
3. A valid Zscaler Branch Connector provisioning URL generated from the Branch Connector Portal
4. Zscaler Branch Connector Credentials (api key, username, password)
5. Download the Branch Connector qcow2 image file and save to the desired deployment type 'bootstrap' directory.

### Branch Connector + App Connector requirements
6. A valid Zscaler Private Access subscription and portal access
7. Zscaler ZPA API Keys. Details on how to find and generate ZPA API keys can be located [here:](https://help.zscaler.com/zpa/about-api-keys)
- Client ID
- Client Secret
- Customer ID
8. (Optional) An existing App Connector Group and Provisioning Key. Otherwise, you can follow the prompts in the examples terraform.tfvars to create a new Connector Group and Provisioning Key

See: [Zscaler Zero Trust SD-WAN Datasheet](https://www.zscaler.com/resources/data-sheets/zscaler-zero-trust-sd-wan.pdf) for more information.

Terraform maps two user defined variables (bc_instance_size, ac_enabled) to locals to automatically configure the necessary CPU, Memory, Disk, and NIC total for Branch Connector. Please refer to the table below to understand the resource requirements and allocation based on the variable inputs (columns 1 and 2).

| (tf var) bc_instance_size | (tf var) ac_enabled | CPU | Memory (GB) | Disk (GB) | NICs |
|:-------------------------:|:-------------------:|:---:|:-----------:|:---------:|:----:|
| small                     | false               | 2   | 4           | 128       | 2    |
| small                     | true                | 4   | 16          | 128       | 3    |
| medium                    | false               | 4   | 8           | 128       | 4    |
| medium                    | true                | 6   | 32          | 128       | 5    |

## Deploying the cluster
(The automated tool can run only from MacOS and Linux. If required to run from a Windows workstation, the preferred method is executing within a Windows Subsystem Linux (WSL) environment).   

```
bash
cd examples
Optional: Edit the terraform.tfvars file under your desired deployment type (ie: bc) to setup your Branch Connector (Details are documented inside the file)
- ./zsec up
- enter <desired deployment type>
- follow prompts for any additional configuration inputs. *keep in mind, any modifications done to terraform.tfvars first will override any inputs from the zsec script*
- script will detect client operating system and download/run a specific version of terraform in a temporary bin directory
- inputs will be validated and terraform init/apply will automatically exectute.
- verify all resources that will be created/modified and enter "yes" to confirm
```

**Deployment Types**

```
Deployment Type: (bc|bc_ha|bc_ac|bc_ac_ha):
bc: Creates a fully autoprovisioned Branch Connector VM in KVM.
bc_ha: Creates 2 Branch Connector VMs in active-passive HA configuration in KVM.  ***This will deploy both VMs on a single KVM host. For production deployments, it is recommended to deploy VMs on separate physical hypervisor hosts for resiliency.***
bc_ac: Creates a fully autoprovisioned Branch Connector w/ integrated App Connector VM in KVM
bc_ha_ac: Creates 2 Branch Connector w/ integrated App Connector VMs in active-passive HA configuration in KVM.  ***This will deploy both VMs on a single KVM host. For production deployments, it is recommended to deploy VMs on separate physical hypervisor hosts for resiliency.***
```

## Destroying the cluster
```
cd examples
- ./zsec destroy
- verify all resources that will be destroyed and enter "yes" to confirm
```


## Notes
```
1. For auto approval set environment variable **AUTO_APPROVE** or add `export AUTO_APPROVE=1`
2. For deployment type set environment variable **dtype** to the required deployment type or add `export dtype=bc`
3. To provide new credentials or region, delete the autogenerated .zsecrc file in your current working directory and re-run zsec.
```
