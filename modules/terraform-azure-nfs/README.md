<!-- BEGIN_TF_DOCS -->
# Terraform Module for Azure NFS

This module contains resource files and example variable definition files for creation of the Azure NFS File Share required for Cloudera Machine Learning (CML) Public Cloud.

* Provisions a storage account with Premium Tier and Disabled Https traffic only.
* Creates a NFS file share of 100 GB in the storage account
* Creates a private dns zone of type privatelink.file.core.windows.net
* Creates a VNET link between CDP workload VNET and private DNS zone
* Creates a private endpoint for NFS Storage Account (File sub-resource) for one of the subnets in the CDP VNET - this should be extended to all subnets for CML.
* Creates a public IP , security group allowing port 22 from everywhere
* Creates a ubuntu VM with public IP, security group in the CDP VNET to which private endpoint was created.


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.45.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.39.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.45.0 |

## Usage

The [examples](./examples) directory has example Azure Cloud Service Provider deployments for different scenarios:

* `ex01-nfs_fileshare` uses a set of inputs for the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Resources
| Name | Type |
|------|------|
| [azurem_storage_account.nfs_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account.html) | resource |
| [azurerm_storage_share.nfs_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share.html) | resource |
| [azurerm_private_dns_zone.nfs_privatednszone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.nfs_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.nfs_vm_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_network_interface.nfsvm_nic](https://registry.terraform.io/providers/hashicorp/Azurerm/3.41.0/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.nfsvm_sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_interface_security_group_association.nfsvm_nic_sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association.html) | resource |
| [azurerm_linux_virtual_machine.nfs_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resourcegroup_name"></a> [resourcegroup\_name](#input\_resourcegroup\_name) | CDP Resource Group | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vent\_name](#input\_vnet\_name) | CDP Workload VNET Name | `string` | n/a | yes |
| <a name="input_azure_region"></a> [azure\_region](#azure\_region) | Azure Region | `string` | n/a | yes |
| <a name="input_nfs_storage_account_name"></a> [aws\_region](#nfs\_storage\_account\_name) | NFS Storage Account Name | `string` | n/a | yes |
| <a name="input_env_prefix"></a> [env\_prefix](#env\_prefix) | Shorthand name for the environment. Used in resource descriptions | `string` | n/a | yes |
| <a name="input_nfs_file_share_name"></a> [nfs\_file\_share\_name](#nfs\_file\_share\_name) | NFS File Share Name | `string` | n/a | yes |
| <a name="input_nfs_private_endpoint_target_subnet_name"></a> [aws\_region](#nfs\_private\_endpoint\_target\_subnet\_name) | Subnet to which Azure Files private endpoint is created | `string` | n/a | yes |
| <a name="input_nfs_file_share_size"></a> [nfs\_file\_share\_size](#nfs\_file\_share\_size) | NFS File Share Size | `number` | 100 | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nfs_file_share_url"></a> [nfs\_file\_share\_url](#output\_nfs\_file\_share\_url) | NFS File Share Url |
| <a name="output_nfs_vm_public_ip"></a> [nfs\_vm\_public\_ip](#output\_nfs\_vm\_public\_ip) | Public IP of VM to manage NFS |
