# Building an AKS cluster with help of Terraform

This repo contains Terraform code to build an AKS cluster in Azure.
Done for learning purposes.

Things to build:

- Resource Groups
- A storage account for the statefiles of the other components
- Virtual Network with subnets
- Linux jump server
- Firewall which gives access to:
  - jump server
  - applications running on the AKS cluster

- AKS cluster

Requirements:

- Try to use already created modules.
- Use a storage account for the Terraform state files
- Dependencies, for example the jump server can only be created if the network is available

Findings:

- When using the module to build the networks, you have to be very carefull when you add a subnet. Subnets should not be added at the beginning or in the middle of a map, as this will destroy the already created subnets.


Network setup

One network 10.0.0.0/16 (65534)
subnet AzureFirewallSubnet 10.0.0.0/24 (254)
subnet shared 10.0.2.0/23 (510)
subnet jump 10.0.4.0/24 (254)

subnet dev 10.0.8.0/22 (1022)
subnet tst 10.0.12.0/22 (1022)
subnet acc 10.0.16.0/22 (1022)
subnet prd 10.0.20.0/22 (1022)

All traffic will be routed through the firewall.

- Shared network for shared components like build servers, Jenkins and others.


Network module created. TODO:
- Add state to storage account
- Make sure that adding a subnet, does not require a destroy of already created subnets
- Add routes to the subnets
