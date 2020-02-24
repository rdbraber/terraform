variable "k8s_credentials_keyvault" {
  description = "Key Vault that contains the credentials for the k8s cluster"
  type        = string
}

variable "k8s_credentials_keyvault_resource_group" {
  description = "Resource group of the Key Vault that contains the credentials for the k8s cluster"
  type        = string
}

variable "k8s_secret_keyvault" {
  description = "Key Vault that contains the secret"
  type        = string
}

variable "k8s_secret_keyvault_resource_group" {
  description = "Resource group of the Key Vault that contains the secret"
  type        = string
}

variable "k8s_cluster" {
  description = "Name of the kubernetes cluster"
  type        = string
}

variable "k8s_serviceaccount" {
  description = "Service Account which can be used to create Kubernetes resources"
  type        = string
}

variable "k8s_namespace" {
  description = "K8s Namespace"
  type        = string
}

variable "secret_name" {
  description = "Name of the secret"
  type        = string
}

variable "secret_type" {
  description = "Type of the secret. Can be Opaque, kubernetes.io/service-account-token, kubernetes.io/dockercfg, kubernetes.io/dockerconfigjson"
  type        = string
}
