terraform {
  required_version = ">= 0.12, < 0.13"
}

# Get the credentials and api url for the Kubernetes cluster
data "azurerm_key_vault" "k8s_cred_keyvault" {
  name                = var.k8s_credentials_keyvault
  resource_group_name = var.k8s_credentials_keyvault_resource_group
}

data "azurerm_key_vault_secret" "k8s_token" {
  name         = "${var.k8s_cluster}-${var.k8s_serviceaccount}-token"
  key_vault_id = "${data.azurerm_key_vault.k8s_cred_keyvault.id}"
}

data "azurerm_key_vault_secret" "k8s_cacrt" {
  name         = "${var.k8s_cluster}-${var.k8s_serviceaccount}-cacrt"
  key_vault_id = "${data.azurerm_key_vault.k8s_cred_keyvault.id}"
}

data "azurerm_key_vault_secret" "k8s_api" {
  name         = "${var.k8s_cluster}-api"
  key_vault_id = "${data.azurerm_key_vault.k8s_cred_keyvault.id}"
}

# Get the secret that needs to be added
data "azurerm_key_vault" "k8s_secret_keyvault" {
  name                = var.k8s_secret_keyvault
  resource_group_name = var.k8s_secret_keyvault_resource_group
}

data "azurerm_key_vault_secret" "k8s_secret" {
  name         = var.secret_name
  key_vault_id = "${data.azurerm_key_vault.k8s_cred_keyvault.id}"
}

# Use a ServiceAccount to access the Kubernetes cluster
provider "kubernetes" {
  host                   = data.azurerm_key_vault_secret.k8s_api.value
  token                  = data.azurerm_key_vault_secret.k8s_token.value
  cluster_ca_certificate = data.azurerm_key_vault_secret.k8s_cacrt.value
  # Do not use a local kube config file
  load_config_file = false
}

# Add the secret
resource "kubernetes_secret" "secret" {
  metadata {
    name      = var.secret_name
    namespace = var.k8s_namespace
  }
  data = jsondecode(data.azurerm_key_vault_secret.k8s_secret.value)
  type = var.secret_type
}
