terraform {
  # The modules used in this example have been updated with 0.12 syntax, which means the example is no longer
  # compatible with any versions below 0.12.
  required_version = ">= 0.12, < 0.13"
}

module "network" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "github.com/gruntwork-io/terraform-google-network.git//modules/vpc-network?ref=v0.1.2"
  source = "../../../network"

  location      = var.location
  prefix        = var.prefix
  address_space = var.address_space
  dns_servers   = var.dns_servers
  subnets       = var.subnets
  tags          = var.tags
}
