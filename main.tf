/// Main file ///

// generate id string

resource "random_string" "id" {
  length  = 4
  special = false
  upper   = false
  number  = false
}

// create resource group
module "resourcegroup" {
  source              = "./modules/resourcegroup"
  location            = var.location
  resource_group_name = "${var.resource_group_name}-primary"
  id                  = random_string.id.result
}

// create virual network
module "networkspace" {
  source                = "./modules/network"
  resource_group_name   = "${module.resourcegroup.name}"
  location              = var.location
  network_address_space = var.network_address_space
}

// create virtual machines
module "vm" {
  source                   = "./modules/vm"
  location                 = var.location
  resource_group_name      = module.resourcegroup.name
  winagent_instances_count = var.winagent_instances_count
  virtual_network_name     = module.networkspace.name
  address_prefix           = var.address_prefix
  id                       = random_string.id.result
}
