#!/bin/bash
#
# Script to create secrets in Azure Key Vault, which can be used to test
# the k8s-secret module.

# ClusterName is the name of the Kubernetes cluster where you want to add a secret
ClusterName=local-test-cluster
# ServiceAccount is the name of the Kubernetes Service Account that has the rights to 
# add secrets 
ServiceAccount=terraform-cluster-admin
# KeyVault is the name of the keyvault that will be used for the Kubernetes credentials
KeyVault=linora-solutions-k8s-dev

#SecretFile is the name of the file that contains the secret that needs to be stored in Key Vault
OpaqueSecretFile=Opaque_secrets.txt

# Get the name of the token of the Service Account
ServiceAccountTokenName=`kubectl get serviceaccount -n kube-system ${ServiceAccount} -o yaml |grep token |awk '{print $3}'`
# Get the token of the Service Account
ServiceAccountToken=`kubectl get secret -n kube-system ${ServiceAccountTokenName} -o json | jq -r .data.token|base64 -D`
# Get the ca.crt of the Kubernetes cluster
ClusterCaCert=`kubectl get secret -n kube-system ${ServiceAccountTokenName} -o json | jq -r '.data["ca.crt"]'|base64 -D`
# Get the API endpoint of the Kubernetes cluster
ClusterApi=`kubectl config view |grep server |awk '{print $2}'`

# Add the token to Key Vault
az keyvault secret set --vault-name=$KeyVault --name=${ClusterName}-${ServiceAccount}-token --value="$ServiceAccountToken"
# Add the ca.crt to Key Vault
az keyvault secret set --vault-name=$KeyVault --name=${ClusterName}-${ServiceAccount}-cacrt --value="$ClusterCaCert" --encoding=base64  
# Add the API endpoint to Key Vault
az keyvault secret set --vault-name=$KeyVault --name=${ClusterName}-api --value="$ClusterApi" 
# Add the Opaque Kubernetes secret to Key Vault
az keyvault secret set --vault-name=$KeyVault --name=opaque-test-secret --file=Opaque_secrets.txt
