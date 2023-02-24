variable "bc_count" {
  type        = number
  description = "Default number of Branch Connector appliances to create"
  default     = 1

  validation {
    condition = (
      var.bc_count >= 1 && var.bc_count <= 2
    )
    error_message = "Input bc_count must be set to a single value between 1 and 2."
  }
}

variable "name_prefix" {
  type        = string
  description = "The name prefix for all your resources"
  default     = "zsbc"
}

variable "resource_tag" {
  type        = string
  description = "A tag to associate to all the Branch Connector module resources"
  default     = ""
}

variable "user_data" {
  type        = list(string)
  description = "Cloud Init data"
}

variable "ac_enabled" {
  type        = bool
  description = "True/False to determine how many VM network interfaces should be provisioned"
  default     = false
}

variable "bc_instance_size" {
  type        = string
  description = "Branch Connector Instance size. Determined by and needs to match the Cloud Connector Portal provisioning template configuration"
  default     = "small"
  validation {
    condition = (
      var.bc_instance_size == "small" ||
      var.bc_instance_size == "medium" ||
      var.bc_instance_size == "large"
    )
    error_message = "Input bc_instance_size must be set to an approved value."
  }
}

#Locals matrix to define the number of vNICs to assign to a VM given any combination of size/features
locals {
  control_nic        = var.ac_enabled == true ? ["1"] : []
  small_service_nic  = var.bc_instance_size == "small" ? ["1"] : []
  medium_service_nic = var.bc_instance_size == "medium" ? ["1", "2", "3"] : []
  large_service_nic  = var.bc_instance_size == "large" ? ["1", "2", "3", "4"] : []

  service_nic_count = coalescelist(local.small_service_nic, local.medium_service_nic, local.large_service_nic)
}

#Locals matrix to define the number of vCPU to assign to a VM given any combination of size/features
locals {
  small_bc_cpu     = var.bc_instance_size == "small" && var.ac_enabled == false ? 2 : ""
  small_bc_ac_cpu  = var.bc_instance_size == "small" && var.ac_enabled == true ? 4 : ""
  medium_bc_cpu    = var.bc_instance_size == "medium" && var.ac_enabled == false ? 4 : ""
  medium_bc_ac_cpu = var.bc_instance_size == "medium" && var.ac_enabled == true ? 8 : ""
  large_bc_cpu     = var.bc_instance_size == "large" && var.ac_enabled == false ? 6 : ""
  large_bc_ac_cpu  = var.bc_instance_size == "large" && var.ac_enabled == true ? 10 : ""

  vm_cpus = coalesce(local.small_bc_cpu, local.small_bc_ac_cpu, local.medium_bc_cpu, local.medium_bc_ac_cpu, local.large_bc_cpu, local.large_bc_ac_cpu)
}

#Locals matrix to define the amount of memory to assign to a VM given any combination of size/features
locals {
  small_bc_mem     = var.bc_instance_size == "small" && var.ac_enabled == false ? 4096 : ""
  small_bc_ac_mem  = var.bc_instance_size == "small" && var.ac_enabled == true ? 16384 : ""
  medium_bc_mem    = var.bc_instance_size == "medium" && var.ac_enabled == false ? 8192 : ""
  medium_bc_ac_mem = var.bc_instance_size == "medium" && var.ac_enabled == true ? 24576 : ""
  large_bc_mem     = var.bc_instance_size == "large" && var.ac_enabled == false ? 16384 : ""
  large_bc_ac_mem  = var.bc_instance_size == "large" && var.ac_enabled == true ? 32768 : ""

  vm_memory = coalesce(local.small_bc_mem, local.small_bc_ac_mem, local.medium_bc_mem, local.medium_bc_ac_mem, local.large_bc_mem, local.large_bc_ac_mem)
}

variable "local_qcow2_path" {
  type        = string
  description = "Complete path from local file system to the Branch Connector qcow2 file"
  default     = "../../examples/branchconnector.qcow2"
}

variable "base_volume_name" {
  type        = string
  description = "Name of the base volume where Branch Connector image should reside"
}

variable "model_type" {
  type        = string
  description = "The network interface model type. Supported types are virtio or e1000. Default is virtio"
  default     = "virtio"

  validation {
    condition = (
      var.model_type == "virtio" ||
      var.model_type == "e1000"
    )
    error_message = "Input model_type must be set to either virtio or e1000."
  }
}

variable "autostart" {
  type        = bool
  description = "Set to true to start the domain on host boot up. If not specified false is assumed"
  default     = false
}

variable "host_name" {
  type        = string
  description = "The hostname that will be assigned to this domain resource in this network"
  default     = ""
}

variable "pool_name" {
  type        = string
  description = "The name of the volume where VM and cloudinit disks will be stored"
  default     = "default"
}

variable "management_network_name" {
  type        = string
  description = "The name of the network for VM management network interface to be created in"
  default     = "default"
}

variable "service_network_name" {
  type        = string
  description = "The name of the network for VM service network interfaces to be created in"
  default     = "default"
}
