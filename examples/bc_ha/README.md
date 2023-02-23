# Zscaler "bc_ha" deployment type

This deployment type is intended for fully functional Zscaler Branch Connector virtual appliance deployments in a KVM environment. This template is intended to deploy 2 VMs in an Active/Passive HA configuration.

## How to deploy:

### Option 1 (guided):
From the examples directory, run the zsec bash script that walks to all required inputs.
- ./zsec up
- enter "bc_ha"
- follow the remainder of the authentication and configuration input prompts.
- script will detect client operating system and download/run a specific version of terraform in a temporary bin directory
- inputs will be validated and terraform init/apply will automatically exectute.
- verify all resources that will be created/modified and enter "yes" to confirm

### Option 2 (manual):
Modify/populate any required variable input values in bc_ha/terraform.tfvars file and save.

From bc_ha directory execute:
- terraform init
- terraform apply

## How to destroy:

### Option 1 (guided):
From the examples directory, run the zsec bash script that walks to all required inputs.
- ./zsec destroy

### Option 2 (manual):
From bc_ha directory execute:
- terraform destroy

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7, < 2.0.0 |
| <a name="requirement_libvirt"></a> [libvirt](#requirement\_libvirt) | ~> 0.7.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.2.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.3.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | ~> 2.2.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.3.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 3.4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bc_vm"></a> [bc\_vm](#module\_bc\_vm) | ../../modules/terraform-zsbc-bcvm-libvirt | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.private_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.testbed](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_sensitive_file.dhcp_user_data_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.static_user_data_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [tls_private_key.key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autostart"></a> [autostart](#input\_autostart) | Set to true to start the domain on host boot up. If not specified false is assumed | `bool` | `false` | no |
| <a name="input_base_volume_name"></a> [base\_volume\_name](#input\_base\_volume\_name) | Name of the base volume where Branch Connector image should reside | `string` | `"zscaleros_bc_kvm"` | no |
| <a name="input_bc_api_key"></a> [bc\_api\_key](#input\_bc\_api\_key) | Branch Connector Portal API Key | `string` | `""` | no |
| <a name="input_bc_count"></a> [bc\_count](#input\_bc\_count) | Default number of Branch Connector appliances to create | `number` | `2` | no |
| <a name="input_bc_instance_size"></a> [bc\_instance\_size](#input\_bc\_instance\_size) | Branch Connector Instance size. Determined by and needs to match the Cloud Connector Portal provisioning template configuration | `string` | `"small"` | no |
| <a name="input_bc_password"></a> [bc\_password](#input\_bc\_password) | Admin Password for Branch Connector Portal authentication | `string` | `""` | no |
| <a name="input_bc_username"></a> [bc\_username](#input\_bc\_username) | Admin Username for Branch Connector Portal authentication | `string` | `""` | no |
| <a name="input_bc_vm_prov_url"></a> [bc\_vm\_prov\_url](#input\_bc\_vm\_prov\_url) | Zscaler Branch Connector Provisioning URL | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_dns_suffix"></a> [dns\_suffix](#input\_dns\_suffix) | Primary DNS suffix for BC management interface if statically setting via provisioning url | `string` | `""` | no |
| <a name="input_host_name"></a> [host\_name](#input\_host\_name) | The hostname that will be assigned to this domain resource in this network | `string` | `""` | no |
| <a name="input_management_network_name"></a> [management\_network\_name](#input\_management\_network\_name) | The name of the network for VM management network interface to be created in | `string` | `"default"` | no |
| <a name="input_mgmt_dns_primary"></a> [mgmt\_dns\_primary](#input\_mgmt\_dns\_primary) | Primary DNS server for BC management interface if statically setting via provisioning url | `string` | `""` | no |
| <a name="input_mgmt_dns_secondary"></a> [mgmt\_dns\_secondary](#input\_mgmt\_dns\_secondary) | Secondary DNS server for BC management interface if statically setting via provisioning url | `string` | `""` | no |
| <a name="input_mgmt_gateway"></a> [mgmt\_gateway](#input\_mgmt\_gateway) | Default gateway for BC management interface if statically setting via provisioning url | `string` | `""` | no |
| <a name="input_mgmt_ip"></a> [mgmt\_ip](#input\_mgmt\_ip) | IP address for BC management interface if statically setting via provisioning url | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_mgmt_netmask"></a> [mgmt\_netmask](#input\_mgmt\_netmask) | Network mask for BC management interface if statically setting via provisioning url | `string` | `""` | no |
| <a name="input_model_type"></a> [model\_type](#input\_model\_type) | The network interface model type. Supported types are virtio or e1000. Default is virtio | `string` | `"virtio"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The name prefix for all your resources | `string` | `"zsbc"` | no |
| <a name="input_pool_name"></a> [pool\_name](#input\_pool\_name) | The name of the volume where VM and cloudinit disks will be stored | `string` | `"default"` | no |
| <a name="input_qcow2_name"></a> [qcow2\_name](#input\_qcow2\_name) | Name of the Branch Connector qcow2 file | `string` | n/a | yes |
| <a name="input_service_network_name"></a> [service\_network\_name](#input\_service\_network\_name) | The name of the network for VM service network interfaces to be created in | `string` | `"default"` | no |
| <a name="input_static_management"></a> [static\_management](#input\_static\_management) | Determines which locals inputs to use in order to generate user-data file. Default is false for DHCP | `bool` | `false` | no |
| <a name="input_tls_key_algorithm"></a> [tls\_key\_algorithm](#input\_tls\_key\_algorithm) | algorithm for tls\_private\_key resource | `string` | `"RSA"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_testbedconfig"></a> [testbedconfig](#output\_testbedconfig) | Output of of all exported attributes to be written to a local file |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
