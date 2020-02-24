# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "prefix" {
  description = "Prefix which will be used in the resource group and network name"
  type        = "string"
}

variable "location" {
  description = "The Azure location"
  type        = string
}

variable "tags" {
  description = "Tags for the resource group and network"
  type        = map
}

variable "bastion_network_name" {
  description = "Network name for the bastion host"
  type = string
}
