## This is only a sample terraform.tfvars file.
## Uncomment and change the below variables according to your specific environment

#####################################################################################################################
##### Variables are populated automically if terraform is ran via ZSEC bash script.       ##### 
##### Modifying the variables in this file will override any inputs from ZSEC             #####
#####################################################################################################################

#####################################################################################################################
##### Cloud Init Userdata Provisioning variables  #####
#####################################################################################################################

## 1. Provide your existing ZPA App Connector provisioning key

#ac_provisioning_key                            = "key-name-from-zpa-portal"

## 2. Zscaler Branch Connector Provisioning URL E.g. connector.zscaler.net/api/v1/provUrl?name=kvm_prov_url

#bc_vm_prov_url                                 = ["connector.zscaler.net/api/v1/provUrl?name=kvm_prov_url_bc_1","connector.zscaler.net/api/v1/provUrl?name=kvm_prov_url_bc_2"]

## 3. Zscaler provisioning user account

#bc_username                                    = "replace-with-bc-deployment-user"

## 4. Zscaler provisioning user password

#bc_password                                    = "replace-with-bc-deployment-password"

## 5. Zscaler Branch Connector API Key

#bc_api_key                                     = "replace-with-api-key"

#####################################################################################################################
##### Only required if statically setting network connectivity for Branch Connector VMs  #####
##### Skip if VMs/provisioning template is configured for DHCP                           #####
#####################################################################################################################

## 6. Determines which locals inputs to use in order to generate user-data file. Default is false for DHCP.
##    Uncomment if you will be manually setting IP address details below

#static_management                              = true

## 7. Name of BC management interface if statically setting via provisioning url. Valid options are 'vtnet0' or 'igb0'

#mgmt_name                                      = "vtnet0"

## 8. IP address for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#mgmt_ip                                        = ["10.0.0.5","10.0.0.6"]  #Where 10.0.0.5 is BC-1 and 10.0.0.6 is BC-2

## 9. Network mask for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#mgmt_netmask                                   = "255.255.255.0"

## 10. Default gateway for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#mgmt_gateway                                   = "10.0.0.1"

## 11. Primary/Secondary DNS servers for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#mgmt_dns_primary                               = "10.0.0.100"
#mgmt_dns_secondary                             = "10.0.0.101"

## 12. Primary DNS suffix for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#dns_suffix                                     = "internal.corp.com"

## 13. Name of BC control interface if statically setting via provisioning url. Valid options are 'vtnet1' or 'igb1'

#control_name                                   = "vtnet1"

## 14. IP address for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#control_ip                                     = ["10.0.0.7","10.0.0.8"]  #Where 10.0.0.7 is BC-1 and 10.0.0.8 is BC-2

## 15. Network mask for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#control_netmask                                = "255.255.255.0"

## 16. Default gateway for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#control_gateway                                = "10.0.0.1"

#####################################################################################################################
##### Custom variables. Only change if required for your environment  #####
#####################################################################################################################

## 17. Name of the Zscaler Branch Connector qcow2 file to be used for deployment. This file name must be located in
##     examples/bc/bootstrap directory.

#qcow2_name                                     = "branchconnector.qcow2"

## 18. Branch Connector Instance size selection. Uncomment bc_instance_size line with desired vm size to change
##    (Default: "small") 
##    **** NOTE - This value is used by the vm module to determine how many network interfaces, CPU, and memory
##                are required for any VM. 

#bc_instance_size                               = "small"
#bc_instance_size                               = "medium"

## 19. Optional: Custome VM Hostname entries. Terraform auto populates values. Only set this if you need to override
##     the automatically created names.

#host_name                                      = ["replace-with-host-ip/name"]

## 20. The name of the volume where VM and cloudinit disks will be stored

#pool_name                                      = "replace-with-pool-name"

## 21. The name of the network for VM management network interface to be created in

#management_network_name                        = "replace-with-network-name"

## 22. The name of the network for VM service network interfaces to be created in

#service_network_name                           = "replace-with-network-name"

## 23. Model type for the network interfaces. Default: virtio

#model_type                                     = "virtio"
#model_type                                     = "e1000"

## 24. Name of the base volume to create where Branch Connector image should reside

#base_volume_name                               = zscaleros_bc_kvm

## 25. By default, Terraform will generate a new SSH Private/Public Key Pair that can be used to access the Branch Connector VM.
##     Uncomment and enter an SSH Public Key if you would rather use your own and not create a new one.

#byo_ssh_key                            = "ssh-rsa AAAA etc"
