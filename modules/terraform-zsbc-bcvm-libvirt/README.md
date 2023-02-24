# Zscaler Branch Connector / Libvirt (KVM) VM Module

This module can be used to deploy a customized Zscaler Branch Connector VM from a local qcow2 image. It includes userdata cloudinit ISO disk creation for a complete, zero-touch provisioning process.

Caveats:<br>
On Ubuntu distros SELinux is enforced by qemu even if it is disabled globally, this might cause unexpected `Could not open '/var/lib/libvirt/images/<FILE_NAME>': Permission denied` errors. Double check that `security_driver = "none"` is uncommented in `/etc/libvirt/qemu.conf` and issue `sudo systemctl restart libvirt-bin` to restart the daemon.<br>

This module takes network name as a string input only, so the networks need to already be provisioned in KVM. Terraform will not create them.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7, < 2.0.0 |
| <a name="requirement_libvirt"></a> [libvirt](#requirement\_libvirt) | ~> 0.7.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_libvirt"></a> [libvirt](#provider\_libvirt) | ~> 0.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [libvirt_cloudinit_disk.bc_cloudinit_disk](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/cloudinit_disk) | resource |
| [libvirt_domain.bc_vm](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/domain) | resource |
| [libvirt_volume.bc_base_volume](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/volume) | resource |
| [libvirt_volume.bc_volume](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/volume) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ac_enabled"></a> [ac\_enabled](#input\_ac\_enabled) | True/False to determine how many VM network interfaces should be provisioned | `bool` | `false` | no |
| <a name="input_autostart"></a> [autostart](#input\_autostart) | Set to true to start the domain on host boot up. If not specified false is assumed | `bool` | `false` | no |
| <a name="input_base_volume_name"></a> [base\_volume\_name](#input\_base\_volume\_name) | Name of the base volume where Branch Connector image should reside | `string` | n/a | yes |
| <a name="input_bc_count"></a> [bc\_count](#input\_bc\_count) | Default number of Branch Connector appliances to create | `number` | `1` | no |
| <a name="input_bc_instance_size"></a> [bc\_instance\_size](#input\_bc\_instance\_size) | Branch Connector Instance size. Determined by and needs to match the Cloud Connector Portal provisioning template configuration | `string` | `"small"` | no |
| <a name="input_host_name"></a> [host\_name](#input\_host\_name) | The hostname that will be assigned to this domain resource in this network | `string` | `""` | no |
| <a name="input_local_qcow2_path"></a> [local\_qcow2\_path](#input\_local\_qcow2\_path) | Complete path from local file system to the Branch Connector qcow2 file | `string` | `"../../examples/branchconnector.qcow2"` | no |
| <a name="input_management_network_name"></a> [management\_network\_name](#input\_management\_network\_name) | The name of the network for VM management network interface to be created in | `string` | `"default"` | no |
| <a name="input_model_type"></a> [model\_type](#input\_model\_type) | The network interface model type. Supported types are virtio or e1000. Default is virtio | `string` | `"virtio"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The name prefix for all your resources | `string` | `"zsbc"` | no |
| <a name="input_pool_name"></a> [pool\_name](#input\_pool\_name) | The name of the volume where VM and cloudinit disks will be stored | `string` | `"default"` | no |
| <a name="input_resource_tag"></a> [resource\_tag](#input\_resource\_tag) | A tag to associate to all the Branch Connector module resources | `string` | `""` | no |
| <a name="input_service_network_name"></a> [service\_network\_name](#input\_service\_network\_name) | The name of the network for VM service network interfaces to be created in | `string` | `"default"` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Cloud Init data | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The unique identifier of the virtual machine |
| <a name="output_ip"></a> [ip](#output\_ip) | The primary IP address of the virtual machine |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
