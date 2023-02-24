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

variable "ac_enabled" {
  type        = bool
  description = "True/False to determine how many VM network interfaces should be provisioned"
  default     = true
}

variable "control_ip" {
  type        = list(string)
  description = "IP address for BC/AC control interface if statically setting via provisioning url. Leave blank if using DHCP"
  default     = [""]
}

variable "control_netmask" {
  type        = string
  description = "Network mask for BC/AC control interface if statically setting via provisioning url. Leave blank if using DHCP"
  default     = ""
}

variable "control_gateway" {
  type        = string
  description = "Default gateway for BC/AC control interface if statically setting via provisioning url. Leave blank if using DHCP"
  default     = ""
}

variable "mgmt_name" {
  type        = string
  description = "Name of BC management interface if statically setting via provisioning url. Valid options are 'vtnet0' or 'igb0'"
  default     = "vtnet0"
}

variable "control_name" {
  type        = string
  description = "Name of BC control interface if statically setting via provisioning url. Valid options are 'vtnet1' or 'igb1'"
  default     = "vtnet1"
}


# ZPA Provider specific variables for App Connector Group and Provisioning Key creation
variable "byo_provisioning_key" {
  type        = bool
  description = "Bring your own App Connector Provisioning Key. Setting this variable to true will effectively instruct this module to not create any resources and only reference data resources from values provided in byo_provisioning_key_name"
  default     = false
}

variable "byo_provisioning_key_name" {
  type        = string
  description = "Existing App Connector Provisioning Key name"
  default     = "provisioning-key-tf"
}

variable "enrollment_cert" {
  type        = string
  description = "Get name of ZPA enrollment cert to be used for App Connector provisioning"
  default     = "Connector"

  validation {
    condition = (
      var.enrollment_cert == "Root" ||
      var.enrollment_cert == "Client" ||
      var.enrollment_cert == "Connector" ||
      var.enrollment_cert == "Service Edge" ||
      var.enrollment_cert == "Isolation Client"
    )
    error_message = "Input enrollment_cert must be set to an approved value."
  }
}

variable "app_connector_group_name" {
  type        = string
  description = "Custom name for App Connector Group created"
  default     = ""
}

variable "app_connector_group_description" {
  type        = string
  description = "Optional: Description of the App Connector Group"
  default     = "This App Connector Group belongs to: "
}

variable "app_connector_group_enabled" {
  type        = bool
  description = "Whether this App Connector Group is enabled or not"
  default     = true
}

variable "app_connector_group_country_code" {
  type        = string
  description = "Optional: Country code of this App Connector Group. example 'US'"
  default     = ""
}

variable "app_connector_group_latitude" {
  type        = string
  description = "Latitude of the App Connector Group. Integer or decimal. With values in the range of -90 to 90"
  default     = "37.3382082"
}

variable "app_connector_group_longitude" {
  type        = string
  description = "Longitude of the App Connector Group. Integer or decimal. With values in the range of -90 to 90"
  default     = "-121.8863286"
}

variable "app_connector_group_location" {
  type        = string
  description = "location of the App Connector Group in City, State, Country format. example: 'San Jose, CA, USA'"
  default     = "San Jose, CA, USA"
}

variable "app_connector_group_upgrade_day" {
  type        = string
  description = "Optional: App Connectors in this group will attempt to update to a newer version of the software during this specified day. Default value: SUNDAY. List of valid days (i.e., SUNDAY, MONDAY, etc)"
  default     = "SUNDAY"
}

variable "app_connector_group_upgrade_time_in_secs" {
  type        = string
  description = "Optional: App Connectors in this group will attempt to update to a newer version of the software during this specified time. Default value: 66600. Integer in seconds (i.e., 66600). The integer should be greater than or equal to 0 and less than 86400, in 15 minute intervals"
  default     = "66600"
}

variable "app_connector_group_override_version_profile" {
  type        = bool
  description = "Optional: Whether the default version profile of the App Connector Group is applied or overridden. Default: false"
  default     = false
}

variable "app_connector_group_version_profile_id" {
  type        = string
  description = "Optional: ID of the version profile. To learn more, see Version Profile Use Cases. https://help.zscaler.com/zpa/configuring-version-profile"
  default     = "2"

  validation {
    condition = (
      var.app_connector_group_version_profile_id == "0" || #Default = 0
      var.app_connector_group_version_profile_id == "1" || #Previous Default = 1
      var.app_connector_group_version_profile_id == "2"    #New Release = 2
    )
    error_message = "Input app_connector_group_version_profile_id must be set to an approved value."
  }
}

variable "app_connector_group_dns_query_type" {
  type        = string
  description = "Whether to enable IPv4 or IPv6, or both, for DNS resolution of all applications in the App Connector Group"
  default     = "IPV4_IPV6"

  validation {
    condition = (
      var.app_connector_group_dns_query_type == "IPV4_IPV6" ||
      var.app_connector_group_dns_query_type == "IPV4" ||
      var.app_connector_group_dns_query_type == "IPV6"
    )
    error_message = "Input app_connector_group_dns_query_type must be set to an approved value."
  }
}

variable "provisioning_key_name" {
  type        = string
  description = "Custom name for App Connector Provisioning Key created"
  default     = ""
}

variable "provisioning_key_enabled" {
  type        = bool
  description = "Whether the provisioning key is enabled or not. Default: true"
  default     = true
}

variable "provisioning_key_association_type" {
  type        = string
  description = "Specifies the provisioning key type for App Connectors or ZPA Private Service Edges. The supported values are CONNECTOR_GRP and SERVICE_EDGE_GRP"
  default     = "CONNECTOR_GRP"

  validation {
    condition = (
      var.provisioning_key_association_type == "CONNECTOR_GRP" ||
      var.provisioning_key_association_type == "SERVICE_EDGE_GRP"
    )
    error_message = "Input provisioning_key_association_type must be set to an approved value."
  }
}

variable "provisioning_key_max_usage" {
  type        = number
  description = "The maximum number of instances where this provisioning key can be used for enrolling an App Connector or Service Edge"
  default     = 10
}
