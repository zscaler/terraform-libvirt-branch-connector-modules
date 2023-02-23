################################################################################
# 1. Generate a unique random string for resource name assignment
################################################################################
resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
}

################################################################################
# The following lines generates a new SSH key pair and stores the PEM file 
# locally. The public key output is used as the instance_key passed variable 
# to the vm modules for admin_ssh_key public_key authentication.
# This is not recommended for production deployments. Please consider modifying 
# to pass your own custom public key file located in a secure location.   
################################################################################
# private key for login
resource "tls_private_key" "key" {
  algorithm = var.tls_key_algorithm
}

# write private key to local pem file
resource "local_file" "private_key" {
  content         = tls_private_key.key.private_key_pem
  filename        = "../${var.name_prefix}-key-${random_string.suffix.result}.pem"
  file_permission = "0600"
}


################################################################################
# 2A. Create the dhcp user_data file. Used if variable static_management is  
#     set to false
################################################################################
locals {
  userdata_dhcp = <<USERDATA
ZSCALER:
  cc_url: ${element(var.bc_vm_prov_url, 0)}
DEV:
  api_key: ${var.bc_api_key}
  username: ${var.bc_username}
  password: ${var.bc_password}
ssh_authorized_keys:
    - ${tls_private_key.key.public_key_openssh}
USERDATA
}

resource "local_sensitive_file" "dhcp_user_data_file" {
  count    = var.static_management == false ? 1 : 0
  content  = local.userdata_dhcp
  filename = "bootstrap/bc-${count.index + 1}/user-data"
}


################################################################################
# 2B. Create the static user_data file. Used if variable static_management is 
#     set to true
################################################################################
locals {
  userdata_static = <<USERDATA
ZSCALER:
  cc_url: ${element(var.bc_vm_prov_url, 0)}
DEV:
  api_key: ${var.bc_api_key}
  username: ${var.bc_username}
  password: ${var.bc_password}
ssh_authorized_keys:
    - ${tls_private_key.key.public_key_openssh}
management_interface:
  name: '${var.mgmt_name}'
  ip: '${element(var.mgmt_ip, 0)}'
  netmask: '${var.mgmt_netmask}'
  gateway: '${var.mgmt_gateway}'
resolv_conf:
  nameservers: ['${var.mgmt_dns_primary}', '${var.mgmt_dns_secondary}']
  domain: '${var.dns_suffix}'
USERDATA
}

resource "local_sensitive_file" "static_user_data_file" {
  count    = var.static_management == true ? 1 : 0
  content  = local.userdata_static
  filename = "bootstrap/bc-${count.index + 1}/user-data"
}


###############################################################################
locals {
  user_data_selected = [
    try(local_sensitive_file.static_user_data_file[0].content, local_sensitive_file.dhcp_user_data_file[0].content)
  ]
}


################################################################################
# 3. Create specified number of Branch Connector VMs from qcow2 template.
#    Also, referenced userdata ISO file is used from CD-ROM mounting via
#    automatic upload to datastore(s) or from existing path/name directly. 
################################################################################
module "bc_vm" {
  source                  = "../../modules/terraform-zsbc-bcvm-libvirt"
  bc_count                = var.bc_count
  name_prefix             = var.name_prefix
  resource_tag            = random_string.suffix.result
  user_data               = local.user_data_selected
  host_name               = var.host_name
  local_qcow2_path        = fileexists("bootstrap/${var.qcow2_name}") ? "${abspath(path.root)}/bootstrap/${var.qcow2_name}" : "qcow2 file name and/or path is wrong. Please fix and re-run terraform"
  bc_instance_size        = var.bc_instance_size
  base_volume_name        = var.base_volume_name
  model_type              = var.model_type
  pool_name               = var.pool_name
  management_network_name = var.management_network_name
  service_network_name    = var.service_network_name
  autostart               = var.autostart
}
