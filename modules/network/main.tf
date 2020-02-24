terraform {
  required_version = ">= 0.12, < 0.13"
  backend "azurerm" {}
}


# Create the resource group.
resource "azurerm_resource_group" "network-rgp" {
  name     = "${var.prefix}-network-rgp"
  location = var.location
  tags     = var.tags
}

# Create the virtual network.
resource "azurerm_virtual_network" "virt_network" {
  name                = "${var.prefix}-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.network-rgp.name
  address_space       = ["${var.address_space}"]
  dns_servers         = var.dns_servers
  tags                = var.tags
}

# Create the subnets in the virtual network.
resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  resource_group_name  = azurerm_resource_group.network-rgp.name
  virtual_network_name = azurerm_virtual_network.virt_network.name
  name                 = each.key
  address_prefix       = each.value
}