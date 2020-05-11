variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "West Europe"
}

variable "resource_group_name" {
  default = "bamboo_remote_agents"
}