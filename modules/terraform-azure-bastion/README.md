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
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.bastion_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.bastion_sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.ssh](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.bastion_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet_network_security_group_association.bastion_sg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_windows_virtual_machine.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_admin_username"></a> [bastion\_admin\_username](#input\_bastion\_admin\_username) | The administrator username for the bastion host. This is used to log in to the instance. | `string` | n/a | yes |
| <a name="input_bastion_host_name"></a> [bastion\_host\_name](#input\_bastion\_host\_name) | Name of bastion host. | `string` | n/a | yes |
| <a name="input_bastion_ipconfig_name"></a> [bastion\_ipconfig\_name](#input\_bastion\_ipconfig\_name) | Name of bastion IP configuration. | `string` | n/a | yes |
| <a name="input_bastion_nic_name"></a> [bastion\_nic\_name](#input\_bastion\_nic\_name) | Name of bastion network interface. | `string` | n/a | yes |
| <a name="input_bastion_pip_name"></a> [bastion\_pip\_name](#input\_bastion\_pip\_name) | Name of Public IP. | `string` | n/a | yes |
| <a name="input_bastion_region"></a> [bastion\_region](#input\_bastion\_region) | Region which bastion will be created. | `string` | n/a | yes |
| <a name="input_bastion_resourcegroup_name"></a> [bastion\_resourcegroup\_name](#input\_bastion\_resourcegroup\_name) | Bastion resource group name. | `string` | n/a | yes |
| <a name="input_bastion_security_group_name"></a> [bastion\_security\_group\_name](#input\_bastion\_security\_group\_name) | Name of bastion Security Group for CDP environment. | `string` | n/a | yes |
| <a name="input_bastion_subnet_id"></a> [bastion\_subnet\_id](#input\_bastion\_subnet\_id) | The ID of the subnet where the bastion VM will run. | `string` | n/a | yes |
| <a name="input_ssh_public_key_path"></a> [ssh\_public\_key\_path](#input\_ssh\_public\_key\_path) | Path to the SSH public key. One of either admin\_password or admin\_ssh\_key must be specified for Linux. | `string` | n/a | yes |
| <a name="input_bastion_admin_password"></a> [bastion\_admin\_password](#input\_bastion\_admin\_password) | The administrator password for the bastion host. This is used to log in to the instance. Required for Windows. For Linux, if not null, will replace SSH authentication. | `string` | `null` | no |
| <a name="input_bastion_cache"></a> [bastion\_cache](#input\_bastion\_cache) | Bastion OS disk caching. | `string` | `"ReadWrite"` | no |
| <a name="input_bastion_img_offer"></a> [bastion\_img\_offer](#input\_bastion\_img\_offer) | Bastion OS image offer. E.g., 'UbuntuServer', 'WindowsServer' | `string` | `"UbuntuServer"` | no |
| <a name="input_bastion_img_pub"></a> [bastion\_img\_pub](#input\_bastion\_img\_pub) | Bastion OS image publisher. E.g., 'Canonical', 'MicrosoftWindowsServer' | `string` | `"Canonical"` | no |
| <a name="input_bastion_img_sku"></a> [bastion\_img\_sku](#input\_bastion\_img\_sku) | Bastion OS image SKU. E.g., '18.04-LTS', '2019-Datacenter' | `string` | `"18.04-LTS"` | no |
| <a name="input_bastion_img_ver"></a> [bastion\_img\_ver](#input\_bastion\_img\_ver) | Bastion OS image version. | `string` | `"latest"` | no |
| <a name="input_bastion_os_type"></a> [bastion\_os\_type](#input\_bastion\_os\_type) | The operating system type for the Bastion VM. Options are 'Linux' or 'Windows'. | `string` | `"Linux"` | no |
| <a name="input_bastion_pip_static"></a> [bastion\_pip\_static](#input\_bastion\_pip\_static) | Whether the Bastion Public IP should be Static (true) or Dynamic (false). | `bool` | `true` | no |
| <a name="input_bastion_private_ip_static"></a> [bastion\_private\_ip\_static](#input\_bastion\_private\_ip\_static) | Whether the Bastion Private IP should be Static (true) or Dynamic (false). | `bool` | `false` | no |
| <a name="input_bastion_sa_type"></a> [bastion\_sa\_type](#input\_bastion\_sa\_type) | Bastion OS disk storage type. | `string` | `"Standard_LRS"` | no |
| <a name="input_bastion_size"></a> [bastion\_size](#input\_bastion\_size) | Bastion VM size. | `string` | `"Standard_F2"` | no |
| <a name="input_bastion_user_data"></a> [bastion\_user\_data](#input\_bastion\_user\_data) | Base64-encoded user data for the bastion instance. | `string` | `null` | no |
| <a name="input_replace_on_user_data_change"></a> [replace\_on\_user\_data\_change](#input\_replace\_on\_user\_data\_change) | Trigger a destroy and recreate the VM when user\_data changes. | `bool` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provised resources. | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_instance_details"></a> [bastion\_instance\_details](#output\_bastion\_instance\_details) | The details of the Bastion instance. |
| <a name="output_bastion_instance_id"></a> [bastion\_instance\_id](#output\_bastion\_instance\_id) | The ID of the Bastion instance. |
| <a name="output_bastion_instance_private_ip"></a> [bastion\_instance\_private\_ip](#output\_bastion\_instance\_private\_ip) | The private IP address of the Bastion instance. |
| <a name="output_bastion_instance_public_ip"></a> [bastion\_instance\_public\_ip](#output\_bastion\_instance\_public\_ip) | The public IP address of the Bastion instance. |
| <a name="output_linux_ssh_command"></a> [linux\_ssh\_command](#output\_linux\_ssh\_command) | For Linux, SSH command required to connect to the Bastion host using the admin username and the public IP address. |
<!-- END_TF_DOCS -->