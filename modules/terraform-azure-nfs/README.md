<!-- BEGIN_TF_DOCS -->
# Terraform Module for Azure NFS

This module contains resource files and example variable definition files for creation of the Azure NFS File Share required for Cloudera Machine Learning (CML) Public Cloud.

* Provisions a storage account with Premium Tier and Disabled Https traffic only.
* Creates a NFS file share of 100 GB in the storage account
* Creates a private dns zone of type privatelink.file.core.windows.net
* Creates a VNET link between CDP workload VNET and private DNS zone
* Creates a private endpoint for NFS Storage Account (File sub-resource) for the specified subnets in the CDP VNET.
* Creates a public IP , security group allowing port 22 from everywhere
* Creates a ubuntu VM with public IP, security group in the CDP Subnets to which private endpoint was created.

## Usage

The [examples](./examples) directory has example Azure Cloud Service Provider deployments for different scenarios:

* `ex01-nfs_fileshare` uses a set of inputs for the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.11.0, <4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.11.0, <4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.nfs_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.nfsvm_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.nfsvm_nic_sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.nfsvm_sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.nfsvm_sg_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_private_dns_zone.nfs_privatednszone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.nfs_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.nfs_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_public_ip.nfsvm_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_storage_account.nfs_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_share.nfs_storage_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_subnet.nfs_subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.nfs_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Region for CDP | `string` | n/a | yes |
| <a name="input_nfs_file_share_name"></a> [nfs\_file\_share\_name](#input\_nfs\_file\_share\_name) | nfs file share name | `string` | n/a | yes |
| <a name="input_nfs_private_endpoint_target_subnet_names"></a> [nfs\_private\_endpoint\_target\_subnet\_names](#input\_nfs\_private\_endpoint\_target\_subnet\_names) | Subnet to which private endpoints are created | `list(string)` | n/a | yes |
| <a name="input_nfs_storage_account_name"></a> [nfs\_storage\_account\_name](#input\_nfs\_storage\_account\_name) | NFS Storage account name | `string` | n/a | yes |
| <a name="input_nfs_vnet_link_name"></a> [nfs\_vnet\_link\_name](#input\_nfs\_vnet\_link\_name) | Name for NFS VNET Link | `string` | n/a | yes |
| <a name="input_nfsvm_name"></a> [nfsvm\_name](#input\_nfsvm\_name) | Name for NFS VM | `string` | n/a | yes |
| <a name="input_nfsvm_nic_name"></a> [nfsvm\_nic\_name](#input\_nfsvm\_nic\_name) | Name for NFS VM NIC | `string` | n/a | yes |
| <a name="input_nfsvm_public_ip_name"></a> [nfsvm\_public\_ip\_name](#input\_nfsvm\_public\_ip\_name) | Name for NFS VM Public IP | `string` | n/a | yes |
| <a name="input_nfsvm_sg_name"></a> [nfsvm\_sg\_name](#input\_nfsvm\_sg\_name) | Name for NFS VM Security Group | `string` | n/a | yes |
| <a name="input_private_endpoint_prefix"></a> [private\_endpoint\_prefix](#input\_private\_endpoint\_prefix) | Shorthand name for the environment. Used in resource descriptions | `string` | n/a | yes |
| <a name="input_public_key_text"></a> [public\_key\_text](#input\_public\_key\_text) | SSH Public key string for the nodes of the CDP environment | `string` | n/a | yes |
| <a name="input_resourcegroup_name"></a> [resourcegroup\_name](#input\_resourcegroup\_name) | Resource Group Name | `string` | n/a | yes |
| <a name="input_source_address_prefixes"></a> [source\_address\_prefixes](#input\_source\_address\_prefixes) | Source address prefixes for VM ssh access | `list(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Vnet name | `string` | n/a | yes |
| <a name="input_nfs_file_share_size"></a> [nfs\_file\_share\_size](#input\_nfs\_file\_share\_size) | NFS File Share size | `number` | `100` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nfs_file_share_url"></a> [nfs\_file\_share\_url](#output\_nfs\_file\_share\_url) | NFS File Share url |
| <a name="output_nfs_vm_public_ip"></a> [nfs\_vm\_public\_ip](#output\_nfs\_vm\_public\_ip) | NFS VM public IP address |
| <a name="output_nfs_vm_username"></a> [nfs\_vm\_username](#output\_nfs\_vm\_username) | NFS VM Admin Username |
<!-- END_TF_DOCS -->