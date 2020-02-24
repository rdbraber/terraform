# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "prefix" {
  description = "Prefix which will be used in the resource group and network name"
  type        = "string"
  default     = "weu-dev"
}

variable "location" {
  description = "The Azure location"
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "Tags for the bastion host"
  default = {
    "created-by" : "Terraform"
    "stage" : "development"
  }
}

variable "bastion_network_name" {
  description = "Network name for the bastion host"
  type = string
  default = "bastion"
}

