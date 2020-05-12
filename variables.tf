variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "West Europe"
}

variable "resource_group_name" {
  default = ""
}

variable network_address_space {
  type    = string
  default = ""
}

variable winagent_instances_count {
  type    = string
  default = ""
}

variable address_prefix {
  type        = string
  default     = ""
}
