variable "bc_count" {
  type        = number
  description = "Default number of Branch Connector appliances to create"
  default     = 2

  validation {
    condition = (
      var.bc_count >= 1 && var.bc_count <= 2
    )
    error_message = "Input bc_count must be set to a single value between 1 and 2."

  }
}

variable "tls_key_algorithm" {
  type        = string
  description = "algorithm for tls_private_key resource"
  default     = "RSA"
}

variable "name_prefix" {
  type        = string
  description = "The name prefix for all your resources"
  default     = "zsbc"
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

variable "bc_vm_prov_url" {
  description = "Zscaler Branch Connector Provisioning URL"
  type        = list(string)
  default     = [""]
}

variable "bc_username" {
  type        = string
  description = "Admin Username for Branch Connector Portal authentication"
  default     = ""
}

variable "bc_password" {
  type        = string
  description = "Admin Password for Branch Connector Portal authentication"
  default     = ""
  sensitive   = true
}

variable "bc_api_key" {
  type        = string
  description = "Branch Connector Portal API Key"
  default     = ""
  sensitive   = true
}

variable "static_management" {
  type        = bool
  description = "Determines which locals inputs to use in order to generate user-data file. Default is false for DHCP"
  default     = false
}

variable "mgmt_ip" {
  type        = list(string)
  description = "IP address for BC management interface if statically setting via provisioning url"
  default     = [""]
}

variable "mgmt_netmask" {
  type        = string
  description = "Network mask for BC management interface if statically setting via provisioning url"
  default     = ""
}

variable "mgmt_gateway" {
  type        = string
  description = "Default gateway for BC management interface if statically setting via provisioning url"
  default     = ""
}

variable "mgmt_dns_primary" {
  type        = string
  description = "Primary DNS server for BC management interface if statically setting via provisioning url"
  default     = ""
}

variable "mgmt_dns_secondary" {
  type        = string
  description = "Secondary DNS server for BC management interface if statically setting via provisioning url"
  default     = ""
}

variable "dns_suffix" {
  type        = string
  description = "Primary DNS suffix for BC management interface if statically setting via provisioning url"
  default     = ""
}

variable "qcow2_name" {
  type        = string
  description = "Name of the Branch Connector qcow2 file"
}

variable "base_volume_name" {
  type        = string
  description = "Name of the base volume where Branch Connector image should reside"
  default     = "zscaleros_bc_kvm"
}

variable "autostart" {
  type        = bool
  description = "Set to true to start the domain on host boot up. If not specified false is assumed"
  default     = false
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

variable "network_name" {
  type        = string
  description = "The name of the network for VM network interfaces to be created in"
  default     = "default"
}
