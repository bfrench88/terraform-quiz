// Overall Plan details
variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = ""
}

variable "resource_group_name" {
  default = ""
}

variable "id" {
  default = ""
}

// Login Details
variable "vm_winagent_admin_username" {
  description = "The admin username of the VM that will be deployed"
  default     = "infra"
}

variable "vm_winagent_admin_password" {
  description = "The admin password to be used on the VMSS that will be deployed. The password must meet the complexity requirements of Azure"
  default     = "&@cGgUq6U%95oKfT"
}

// Firewall Rules
variable "winagent_remote_port_udp" {
  description = "Remote udp port to be used for access to the vms created via the nsg applied to the nics."
  default     = "3389"
}

variable "winagent_remote_ports_tcp" {
  description = "Remote tcp port to be used for access to the vms created via the nsg applied to the nics."
  type        = list(string)
  default     = ["3389"]
}

// Network Details
variable virtual_network_name {
  default = ""
}

variable "network_address_space" {
  default     = ""
  description = "Address space for virtual network"
}

variable "buildagent_address_prefix" {
  description = "Specifies the winagent network subnet"
  default     = ""
}

variable "public_ip_address_allocation" {
  description = "Defines how an IP address is assigned. Options are Static or Dynamic."
  default     = "Static"
}

// Server Details
variable "winagent_instances_count" {
  description = "Specify the number of vm Windows Bamboo Agent instances"
  default     = ""
}

variable "vm_winagent_size" {
  description = "Specifies the size of the Windows Bamboo Agent virtual machine."
  default     = "Standard_D4s_v3"
}

variable "vm_winagent_os_publisher" {
  description = "The name of the publisher of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = "MicrosoftWindowsServer"
}

variable "vm_winagent_os_offer" {
  description = "The name of the offer of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = "WindowsServer"
}

variable "vm_winagent_os_sku" {
  description = "The sku of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = "2016-Datacenter"
}

variable "vm_winagent_os_version" {
  description = "The version of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = "latest"
}

variable "vm_winagent_hostname" {
  description = "local name of the Windows VM"
  default     = "winagent"
}

// Disk configuration
variable "delete_os_disk_on_termination" {
  description = "Delete datadisk when machine is terminated"
  default     = "true"
}

variable "data_winagent_disk_size_gb" {
  description = "Storage data disk size size"
  default     = "100"
}

variable "data_winagent_disk_type" {
  description = "Type of storage to use, options: Standard_LRS - Standard HDD, Premium_LRS - Premium SSD, StandardSSD_LRS - Standard SSD or UltraSSD_LRS - Ultra SSD"
  default     = "Premium_LRS"
}
