provider "azurerm" {
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.short_region}-${var.stage}-TF-state-rgp"
  location = "${var.region}"
}

resource "azurerm_storage_account" "sa" {
  name                     = "linora${var.short_region}${var.stage}tfstate"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  location                 = "${var.region}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    purpose = "terraform-state"
    stage   = "${var.stage}"
  }
}

resource "azurerm_storage_container" "network" {
  name                  = "network"
  storage_account_name  = "${azurerm_storage_account.sa.name}"
  container_access_type = "private"
}

resource "azurerm_storage_container" "linux-bastion" {
  name                  = "linux-bastion"
  storage_account_name  = "${azurerm_storage_account.sa.name}"
  container_access_type = "private"
}

resource "azurerm_storage_container" "firewall" {
  name                  = "firewall"
  storage_account_name  = "${azurerm_storage_account.sa.name}"
  container_access_type = "private"
}
