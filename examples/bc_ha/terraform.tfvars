## This is only a sample terraform.tfvars file.
## Uncomment and change the below variables according to your specific environment

#####################################################################################################################
##### Variables 1-17 are populated automically if terraform is ran via ZSEC bash script.   ##### 
##### Modifying the variables in this file will override any inputs from ZSEC             #####
#####################################################################################################################

#####################################################################################################################
##### Cloud Init Userdata Provisioning variables for VAPP Properties  #####
#####################################################################################################################

## 1. Zscaler Branch Connector Provisioning URL E.g. connector.zscaler.net/api/v1/provUrl?name=kvm_prov_url

#bc_vm_prov_url                         = ["connector.zscaler.net/api/v1/provUrl?name=kvm_prov_url"]

## 2. Zscaler provisioning user account

#bc_username                            = "replace-with-bac-admin-name"

## 3. Zscaler provisioning user password

#bc_password                            = "replace-with-bac-admin-password"

## 4. Zscaler Branch Connector API Key

#bc_api_key                             = "replace-with-api-key"

#####################################################################################################################
##### Only required if statically setting network connectivity for Branch Connector VMs  #####
##### Skip if VMs/provisioning template is configured for DHCP                           #####
#####################################################################################################################

## 5. Determines which locals inputs to use in order to generate user-data file. Default is false for DHCP.
##    Uncomment if you will be manually setting IP address details below

#static_management                      true

## 6. IP address for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#mgmt_ip                                = ["10.0.0.5"]

## 7. Network mask for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#mgmt_netmask                           = "255.255.255.0"

## 8. Default gateway for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#mgmt_gateway                           = "10.0.0.1"

## 9. Primary/Secondary DNS servers for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#mgmt_dns_primary                       = "10.0.0.100"
#mgmt_dns_secondary                     = "10.0.0.101"

## 10. Primary DNS suffix for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#dns_suffix                             = "internal.corp.com"

#####################################################################################################################
##### Custom variables. Only change if required for your environment  #####
#####################################################################################################################

## 11. Name of the Zscaler Branch Connector qcow2 file to be used for deployment. This file name must be located in
##     examples/bc/bootstrap directory.

#qcow2_name                             = "branchconnector.qcow2"

## 12. Branch Connector Instance size selection. Uncomment bc_instance_size line with desired vm size to change
##    (Default: "small") 
##    **** NOTE - This value is used by the vm module to determine how many network interfaces, CPU, and memory
##                are required for any VM. 

#bc_instance_size                       = "small"
#bc_instance_size                       = "medium"
#bc_instance_size                       = "large" 

## 13. Optional: Custome VM Hostname entries. Terraform auto populates values. Only set this if you need to override
##     the automatically created names.

#host_name                              = ["replace-with-host-ip/name"]

## 14. The name of the volume where VM and cloudinit disks will be stored

#pool_name                              = "replace-with-pool-name"

## 15. The name of the network for VM management network interface to be created in

#management_network_name                           = "replace-with-network-name"

## 16. The name of the network for VM service network interfaces to be created in

#service_network_name                           = "replace-with-network-name"

## 17. Model type for the network interfaces. Default: virtio

#model_type                             = "virtio"
#model_type                             = "e1000"

## 18. Name of the base volume to create where Branch Connector image should reside

#base_volume_name                       = zscaleros_bc_kvm
