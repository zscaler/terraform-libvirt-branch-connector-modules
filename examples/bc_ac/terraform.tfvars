## This is only a sample terraform.tfvars file.
## Uncomment and change the below variables according to your specific environment

#####################################################################################################################
##### Variables 5-27 are populated automically if terraform is ran via ZSEC bash script.   ##### 
##### Modifying the variables in this file will override any inputs from ZSEC             #####
#####################################################################################################################

#####################################################################################################################
##### Optional: ZPA Provider Resources. Skip to step 3. if you already have an  #####
##### App Connector Group + Provisioning Key.                                   #####
#####################################################################################################################

## 1. ZPA App Connector Provisioning Key variables. Uncomment and replace default values as desired for your deployment.
##    For any questions populating the below values, please reference: 
##    https://registry.terraform.io/providers/zscaler/zpa/latest/docs/resources/zpa_provisioning_key

#enrollment_cert                                = "Connector"
#provisioning_key_name                          = "new_key_name"
#provisioning_key_enabled                       = true
#provisioning_key_max_usage                     = 10

## 2. ZPA App Connector Group variables. Uncomment and replace default values as desired for your deployment. 
##    For any questions populating the below values, please reference: 
##    https://registry.terraform.io/providers/zscaler/zpa/latest/docs/resources/zpa_app_connector_group

#app_connector_group_name                       = "new_group_name"
#app_connector_group_description                = "group_description"
#app_connector_group_enabled                    = true
#app_connector_group_country_code               = "US"
#app_connector_group_latitude                   = "37.3382082"
#app_connector_group_longitude                  = "-121.8863286"
#app_connector_group_location                   = "San Jose, CA, USA"
#app_connector_group_upgrade_day                = "SUNDAY"
#app_connector_group_upgrade_time_in_secs       = "66600"
#app_connector_group_override_version_profile   = true
#app_connector_group_version_profile_id         = "2"
#app_connector_group_dns_query_type             = "IPV4_IPV6"


#####################################################################################################################
##### Optional: ZPA Provider Resources. Skip to step 5. if you added values for steps 1. and 2. #####
##### meaning you do NOT have a provisioning key already.                                       #####
#####################################################################################################################

## 3. By default, this script will create a new App Connector Group Provisioning Key.
##     Uncomment if you want to use an existing provisioning key (true or false. Default: false)

#byo_provisioning_key                           = true

## 4. Provide your existing provisioning key name. Only uncomment and modify if you set byo_provisioning_key to true

#byo_provisioning_key_name                      = "key-name-from-zpa-portal"


#####################################################################################################################
##### Cloud Init Userdata Provisioning variables for VAPP Properties  #####
#####################################################################################################################

## 5. Zscaler Branch Connector Provisioning URL E.g. connector.zscaler.net/api/v1/provUrl?name=kvm_prov_url

#bc_vm_prov_url                                 = ["connector.zscaler.net/api/v1/provUrl?name=kvm_prov_url"]

## 6. Zscaler provisioning user account

#bc_username                                    = "replace-with-bc-deployment-user"

## 7. Zscaler provisioning user password

#bc_password                                    = "replace-with-bc-deployment-password"

## 8. Zscaler Branch Connector API Key

#bc_api_key                                     = "replace-with-api-key"

#####################################################################################################################
##### Only required if statically setting network connectivity for Branch Connector VMs  #####
##### Skip if VMs/provisioning template is configured for DHCP                           #####
#####################################################################################################################

## 9. Determines which locals inputs to use in order to generate user-data file. Default is false for DHCP.
##    Uncomment if you will be manually setting IP address details below

#static_management                              = true

## 10. Name of BC management interface if statically setting via provisioning url. Valid options are 'vtnet0' or 'igb0'

#mgmt_name                                      = "vtnet0"

## 11. IP address for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#mgmt_ip                                        = ["10.0.0.5"]

## 12. Network mask for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#mgmt_netmask                                   = "255.255.255.0"

## 13. Default gateway for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#mgmt_gateway                                   = "10.0.0.1"

## 14. Primary/Secondary DNS servers for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#mgmt_dns_primary                               = "10.0.0.100"
#mgmt_dns_secondary                             = "10.0.0.101"

## 15. Primary DNS suffix for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#dns_suffix                                     = "internal.corp.com"

## 16. Name of BC control interface if statically setting via provisioning url. Valid options are 'vtnet1' or 'igb1'

#control_name                                   = "vtnet1"

## 17. IP address for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#control_ip                                     = ["10.0.0.6"]

## 18. Network mask for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#control_netmask                                = "255.255.255.0"

## 19. Default gateway for BC management interface if statically setting via provisioning url. Leave blank if using DHCP

#control_gateway                                = "10.0.0.1"

#####################################################################################################################
##### Custom variables. Only change if required for your environment  #####
#####################################################################################################################

## 20. Name of the Zscaler Branch Connector qcow2 file to be used for deployment. This file name must be located in
##     examples/bc/bootstrap directory.

#qcow2_name                                     = "branchconnector.qcow2"

## 21. Branch Connector Instance size selection. Uncomment bc_instance_size line with desired vm size to change
##    (Default: "small") 
##    **** NOTE - This value is used by the vm module to determine how many network interfaces, CPU, and memory
##                are required for any VM. 

#bc_instance_size                               = "small"
#bc_instance_size                               = "medium"

## 22. Optional: Custome VM Hostname entries. Terraform auto populates values. Only set this if you need to override
##     the automatically created names.

#host_name                                      = ["replace-with-host-ip/name"]

## 23. The name of the volume where VM and cloudinit disks will be stored

#pool_name                                      = "replace-with-pool-name"

## 24. The name of the network for VM management network interface to be created in

#management_network_name                        = "replace-with-network-name"

## 25. The name of the network for VM service network interfaces to be created in

#service_network_name                           = "replace-with-network-name"

## 26. Model type for the network interfaces. Default: virtio

#model_type                                     = "virtio"
#model_type                                     = "e1000"

## 27. Name of the base volume to create where Branch Connector image should reside

#base_volume_name                               = zscaleros_bc_kvm
