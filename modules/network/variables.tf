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

variable "address_space" {
  description = "Address space of the network"
  type        = string
}

variable "dns_servers" {
  description = "IP-addresses of the DNS servers which should be used for DNS requests"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for the resource group and network"
  type        = map
}


variable "subnets" {
  description = "All subnets in the network"
  type        = map
}