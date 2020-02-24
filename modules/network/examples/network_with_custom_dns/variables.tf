# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "prefix" {
  description = "Prefix which will be used in the Resource group and network name"
  type        = "string"
  default     = "custom-dns"
}

variable "location" {
  description = "The Azure region."
  type        = string
  default     = "westeurope"
}

variable "address_space" {
  description = "Address space of the network"
  default     = "10.0.0.0/16"
}

variable "dns_servers" {
  description = "IP-addresses of the DNS servers which should be used for DNS requests"
  type        = list(string)
  default     = ["8.8.8.8", "8.8.4.4"]
}

variable "tags" {
  description = "Tags for the network"
  default = {
    "created-by" : "Terraform"
    "stage" : "development"
  }
}

variable "subnets" {
  description = "The subnets that need to be created in the network"
  default = {
    "bastion" : "10.0.0.0/24"
    "dbservers" : "10.0.1.0/24"
  }
}