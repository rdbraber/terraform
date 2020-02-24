terraform {
  required_version = ">= 0.12, < 0.13"
  backend "azurerm" {}
}

# Get the facts of the subnet where the bastion server 
data "azurerm_subnet" "bastion" {
  name                 = "${var.bastion_network_name}"
  virtual_network_name = "${var.prefix}-network"
  resource_group_name  = "${var.prefix}-network-rgp"
}

# Create a resource group for the bastion server
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-bastion-rgp"
  location = "${var.location}"
}

# Create a Network Security Group and rules
resource "azurerm_network_security_group" "bastion-nsg" {
  name                = "${var.prefix}-bastion-nsg"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "217.122.170.24/32"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.rg.name}"
  network_security_group_name = "${azurerm_network_security_group.bastion-nsg.name}"
}

# Create a public ip address for the bastion server
resource "azurerm_public_ip" "pubip" {
  name                = "${var.prefix}-bastion-pip"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${azurerm_resource_group.rg.location}"
  allocation_method   = "Static"
}

# Create an ip configuration for the bastion server
resource "azurerm_network_interface" "bastion" {
  name                      = "${var.prefix}-bastion-nic"
  location                  = "${azurerm_resource_group.rg.location}"
  resource_group_name       = "${azurerm_resource_group.rg.name}"
  network_security_group_id = "${azurerm_network_security_group.bastion-nsg.id}"

  ip_configuration {
    name                          = "${var.prefix}-bastion-ipconfig"
    subnet_id                     = "${data.azurerm_subnet.bastion.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.pubip.id}"
  }
}

# Create the bastion server
resource "azurerm_virtual_machine" "bastion" {
  name                          = "${var.prefix}-bastionvm01"
  location                      = "${azurerm_resource_group.rg.location}"
  resource_group_name           = "${azurerm_resource_group.rg.name}"
  network_interface_ids         = ["${azurerm_network_interface.bastion.id}"]
  vm_size                       = "Standard_B1s"
  delete_os_disk_on_termination = true
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.prefix}-bastionvm01-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.prefix}-bastionvm01"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  
    tags                = var.tags
}