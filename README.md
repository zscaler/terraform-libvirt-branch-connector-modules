<a href="https://terraform.io">
    <img src="https://raw.githubusercontent.com/hashicorp/terraform-website/master/public/img/logo-text.svg" alt="Terraform logo" title="Terraform" height="50" width="250" />
</a>
<a href="https://www.zscaler.com/">
    <img src="https://www.zscaler.com/themes/custom/zscaler/logo.svg" alt="Zscaler logo" title="Zscaler" height="50" width="250" />
</a>

Zscaler Branch Connector Linux KVM Terraform Modules
===========================================================================================================

# **README for Linux KVM Terraform**
This README serves as a quick start guide to deploy Zscaler Branch Connector resources in a Linux KVM environment using Terraform. To learn more about the resources created when deploying Branch Connector with Terraform, see [Deployment Templates for Zscaler Branch Connector](https://help.zscaler.com/cloud-connector/brnch/deployment-templates-zscaler-branch-connector). These deployment templates are intended to be fully functional and self service for production use. All modules may also be utilized as design recommendation based on the [Zscaler Zero Trust SD-WAN Datasheet](https://www.zscaler.com/resources/data-sheets/zscaler-zero-trust-sd-wan.pdf).


## **KVM Deployment Scripts for Terraform**

Use this repository to create the deployment resources required to deploy and operate Branch Connector in an existing Linux KVM environment. The [examples](examples/) directory contains complete automation scripts for all deployment template solutions.

## Prerequisites

Our Deployment scripts are leveraging Terraform v1.1.9 that includes full binary and provider support for MacOS M1 chips, but any Terraform version 0.13.7 and higher should be generally supported.

- provider registry.terraform.io/providers/dmacvicar/libvirt v0.7.x
- provider registry.terraform.io/hashicorp/random v3.3.x
- provider registry.terraform.io/hashicorp/local v2.2.x
- provider registry.terraform.io/hashicorp/null v3.1.x
- provider registry.terraform.io/providers/zscaler/zpa v2.5.x

### KVM requirements
```
1. A valid connection URI to connect to the KVM hypervisor. For full more information on connection URI methods, click [here.](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs)

Note:<br>
On Ubuntu distros SELinux is enforced by qemu even if it is disabled globally, this might cause unexpected `Could not open '/var/lib/libvirt/images/<FILE_NAME>': Permission denied` errors. Double check that `security_driver = "none"` is uncommented in `/etc/libvirt/qemu.conf` and issue `sudo systemctl restart libvirt-bin` to restart the daemon.<br>
```

### Zscaler requirements
```
2. A valid Zscaler Branch Connector provisioning URL generated from the Branch Connector Portal
3. Zscaler Branch Connector Credentials (api key, username, password)
4. Download the Branch Connector qcow2 image file and save to the desired deployment type 'bootstrap' directory.

### Branch Connector + App Connector requirements
5. A valid Zscaler Private Access subscription and portal access
6. Zscaler ZPA API Keys. Details on how to find and generate ZPA API keys can be located [here:](https://help.zscaler.com/zpa/about-api-keys)
- Client ID
- Client Secret
- Customer ID
7. (Optional) An existing App Connector Group and Provisioning Key. Otherwise, you can follow the prompts in the examples terraform.tfvars to create a new Connector Group and Provisioning Key
```

###  **Starter Deployment Template**

Use the [**Starter Deployment Template**](examples/bc/) to deploy your Branch Connector in an existing KVM environment.

### **Starter Deployment Template with App Connector**

Use the [**Starter Deployment Template with App Connector**](examples/bc_ac) to deploy your combined Branch Connector + App Connector in an existing KVM environment.

### **Starter Deployment Template with High-Availability**

Use the [**Starter Deployment Template with High-Availability**](examples/bc_ha) to deploy your Branch Connector in an existing KVM environment. This template achieves high availability between two Branch Connectors.

***This will deploy both VMs on a single KVM host. For production deployments, it is recommended to deploy VMs on separate physical hypervisor hosts for resiliency.***

### **Starter Deployment Template with App Connector and High-Availability**

Use the [**Starter Deployment Template with App Connector and High-Availability**](examples/bc_ha_ac) to deploy your combined Branch Connector + App Connector in an existing KVM environment. This template achieves high availability between two Branch Connectors.

***This will deploy both VMs on a single KVM host. For production deployments, it is recommended to deploy VMs on separate physical hypervisor hosts for resiliency.***
