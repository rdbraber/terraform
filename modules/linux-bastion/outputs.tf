output "public_ip" {
  description = "The public ip address of the bastion"
  value       = azurerm_public_ip.pubip.ip_address
}