output "vnet_id" {
  description = "The id of the vNet"
  value       = azurerm_virtual_network.virt_network.id
}

output "vnet_name" {
  description = "The name of the vNet"
  value       = azurerm_virtual_network.virt_network.name
}

output "subnet_ids" {
  description = "The id's for each subnet"
  value       = values(azurerm_subnet.subnet)[*].id
}