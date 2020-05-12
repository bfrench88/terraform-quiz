variable "location" {
  type        = string
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "West Europe"
}

variable "resource_group_name" {
  type        = string
  description = "The name to be used for the resource group, a random ID will be generated to ensure it is unique"
  default     = ""
}

variable "network_address_space" {
  type        = string
  description = "The network address range to be used to create the virtual network"
  default     = ""
}

variable "winagent_instances_count" {
  type        = string
  description = "How many virtual machines should be created"
  default     = ""
}

variable "address_prefix" {
  type        = string
  description = "The subnet that will be created, this NEEDS to be within the address range created within the virtual network"
  default     = ""
}
