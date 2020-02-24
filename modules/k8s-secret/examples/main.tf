terraform {
  # The modules used in this example have been updated with 0.12 syntax, which means the example is no longer
  # compatible with any versions below 0.12.
  required_version = ">= 0.12, < 0.13"
  backend "azurerm" {
    resource_group_name  = "weu-dev-TF-state-rgp"
    storage_account_name = "linoraweudevtfstate"
    container_name       = "k8s-secrets"
    key                  = "terraform.tfstate"
  }
}

module "k8s-secret" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "github.com/gruntwork-io/terraform-google-network.git//modules/vpc-network?ref=v0.1.2"
  source = "../../k8s-secret"

  k8s_credentials_keyvault                = var.k8s_credentials_keyvault
  k8s_credentials_keyvault_resource_group = var.k8s_credentials_keyvault_resource_group
  k8s_secret_keyvault                     = var.k8s_secret_keyvault
  k8s_secret_keyvault_resource_group      = var.k8s_secret_keyvault_resource_group
  k8s_cluster                             = var.k8s_cluster
  k8s_serviceaccount                      = var.k8s_serviceaccount
  k8s_namespace                           = var.k8s_namespace
  secret_name                             = var.secret_name
  secret_type                             = var.secret_type
}
