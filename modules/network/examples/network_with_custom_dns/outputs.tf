output "vnet_id" {
  description = "The id of the vNet"
  value       = module.network.vnet_id
}

output "vnet_name" {
  description = "The name of the vNet"
  value       = module.network.vnet_name
}

output "subnet_ids" {
  description = "The id's for each subnet"
  value       = module.network.subnet_ids
}