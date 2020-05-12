/// Configure the Providers ///

provider "random" {
  version = "~> 2.0"
}

// Generate random string for dns 
resource "random_string" "dns_id" {
  length  = 6
  special = false
  upper   = false
  number  = false
}

/// Virtual Machine Creation ///

// create Windows Agent machines
resource "azurerm_virtual_machine" "winagent" {
  name                          = "${var.vm_winagent_hostname}-${count.index}-${var.id}"
  count                         = 1
  location                      = var.location
  resource_group_name           = var.resource_group_name
  vm_size                       = var.vm_winagent_size
  network_interface_ids         = [element(azurerm_network_interface.vm-winagent.*.id, count.index)]
  delete_os_disk_on_termination = var.delete_os_disk_on_termination

  storage_image_reference {
    publisher = var.vm_winagent_os_publisher
    offer     = var.vm_winagent_os_offer
    sku       = var.vm_winagent_os_sku
    version   = var.vm_winagent_os_version
  }
  storage_os_disk {
    name          = "osdisk-${var.vm_winagent_hostname}-${count.index}"
    create_option = "FromImage"
    caching       = "ReadWrite"
  }
  os_profile {
    computer_name  = "${var.id}${var.vm_winagent_hostname}${count.index}"
    admin_username = var.vm_winagent_admin_username
    admin_password = var.vm_winagent_admin_password
  }
  os_profile_windows_config {
    provision_vm_agent = true
    winrm {
      protocol = "http"
    }
    enable_automatic_upgrades = false
  }
}

/// Network setup ///

// create network subnet
resource "azurerm_subnet" "vs-buildgent" {
  name                 = "buildagent_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefix       = var.address_prefix
}

// create network security group
resource "azurerm_network_security_group" "vm-winagent" {
  name                = "${var.resource_group_name}-nsg-0"
  location            = var.location
  resource_group_name = var.resource_group_name
}

// create nsg rule
resource "azurerm_network_security_rule" "vm-winagent1" {
  count                       = length(var.winagent_remote_ports_tcp)
  name                        = "allow_remote_management[${element(var.winagent_remote_ports_tcp, count.index)}]"
  description                 = "Allow remote management protocol in TCP"
  priority                    = count.index + 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["${element(var.winagent_remote_ports_tcp, count.index)}"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vm-winagent.name
}

/// create network interfaces ///

// create public IP
resource "azurerm_public_ip" "vm-winagent" {
  count               = var.winagent_instances_count
  name                = "${var.vm_winagent_hostname}-${count.index}-publicIP"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_address_allocation
  domain_name_label   = "${random_string.dns_id.result}${count.index}-win"
}

// create vm nic
resource "azurerm_network_interface" "vm-winagent" {
  count                     = var.winagent_instances_count
  name                      = "nic-${var.vm_winagent_hostname}-${count.index}"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  network_security_group_id = azurerm_network_security_group.vm-winagent.id

  ip_configuration {
    name                          = "ipconfig${count.index}"
    subnet_id                     = azurerm_subnet.vs-buildgent.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = length(azurerm_public_ip.vm-winagent.*.id) > 0 ? element(
      concat(azurerm_public_ip.vm-winagent.*.id, [""]),
      count.index,
    ) : ""
  }
}

/// Data Drives ///

// Create Data Drives
resource "azurerm_managed_disk" "winagent-data1" {
  count                = var.winagent_instances_count
  name                 = "datadisk-${var.vm_winagent_hostname}-${count.index}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.data_winagent_disk_type
  create_option        = "Empty"
  disk_size_gb         = var.data_winagent_disk_size_gb
}

// Attach Windows Agent Data Drive
resource "azurerm_virtual_machine_data_disk_attachment" "winagent-data1" {
  count              = var.winagent_instances_count
  managed_disk_id    = azurerm_managed_disk.winagent-data1[count.index].id
  virtual_machine_id = element(azurerm_virtual_machine.winagent.*.id, count.index)
  lun                = 10 + count.index
  caching            = "ReadWrite"
}
