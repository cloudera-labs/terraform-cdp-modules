<!-- BEGIN_TF_DOCS -->
# Terraform Module for Azure Bastion Host

This module contains resource files and example variable definition files to create a Bastion Host on Azure. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a secure environment, where the CDP Environment requires a Bastion host.

## Usage

The [examples](./examples) directory has example Azure Cloud Service Provider deployments for different scenarios:

* `ex01-minimal_inputs` demonstrates how this module can be used to create a Bastion Host in a Vnet.

The sample `terraform.tfvars.sample` describes the required inputs for the example.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_bastion_host.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |
| [azurerm_public_ip.bastion_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | n/a | `string` | n/a | yes |
| <a name="input_bastion_host_name"></a> [bastion\_host\_name](#input\_bastion\_host\_name) | Name of bastion host. | `string` | n/a | yes |
| <a name="input_bastion_ipconfig_name"></a> [bastion\_ipconfig\_name](#input\_bastion\_ipconfig\_name) | Name of IP configuration of bastion host | `string` | n/a | yes |
| <a name="input_bastion_public_ip_name"></a> [bastion\_public\_ip\_name](#input\_bastion\_public\_ip\_name) | Name of Public IP | `string` | n/a | yes |
| <a name="input_bastion_resourcegroup_name"></a> [bastion\_resourcegroup\_name](#input\_bastion\_resourcegroup\_name) | Bastion Resource Group Name | `string` | n/a | yes |
| <a name="input_bastion_subnet_id"></a> [bastion\_subnet\_id](#input\_bastion\_subnet\_id) | Subnet ID for bastion | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provised resources | `map(any)` | `null` | no |
| <a name="input_use_static_public_ip"></a> [use\_static\_public\_ip](#input\_use\_static\_public\_ip) | If true, creates a static public IP. Otherwise, creates a dynamic public IP. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_host_name"></a> [bastion\_host\_name](#output\_bastion\_host\_name) | n/a |
| <a name="output_bastion_public_ip"></a> [bastion\_public\_ip](#output\_bastion\_public\_ip) | Bastion public IP |
<!-- END_TF_DOCS -->