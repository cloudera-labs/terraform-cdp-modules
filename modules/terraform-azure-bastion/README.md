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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.5.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.bastion_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.bastion_sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.ingress_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
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
| <a name="input_bastion_public_ip_name"></a> [bastion\_public\_ip\_name](#input\_bastion\_public\_ip\_name) | Name of Public IP. | `string` | n/a | yes |
| <a name="input_bastion_region"></a> [bastion\_region](#input\_bastion\_region) | Region which bastion will be created. | `string` | n/a | yes |
| <a name="input_bastion_resourcegroup_name"></a> [bastion\_resourcegroup\_name](#input\_bastion\_resourcegroup\_name) | Bastion resource group name. | `string` | n/a | yes |
| <a name="input_bastion_subnet_id"></a> [bastion\_subnet\_id](#input\_bastion\_subnet\_id) | The ID of the subnet where the bastion VM will run. | `string` | n/a | yes |
| <a name="input_bastion_admin_password"></a> [bastion\_admin\_password](#input\_bastion\_admin\_password) | The admin password for the bastion. Required for Windows Bastion. | `string` | `null` | no |
| <a name="input_bastion_cache"></a> [bastion\_cache](#input\_bastion\_cache) | Bastion OS disk caching. | `string` | `"ReadWrite"` | no |
| <a name="input_bastion_image_reference"></a> [bastion\_image\_reference](#input\_bastion\_image\_reference) | The image reference for the bastion host. | <pre>object({<br/>    publisher = string # Bastion OS image publisher. E.g., 'Canonical', 'MicrosoftWindowsServer'<br/>    offer     = string # Bastion OS image offer. E.g., 'UbuntuServer', 'WindowsServer'<br/>    sku       = string # Bastion OS image SKU. E.g., '18.04-LTS', '2019-Datacenter'<br/>    version   = string # Bastion OS image version.<br/>  })</pre> | <pre>{<br/>  "offer": "ubuntu-24_04-lts",<br/>  "publisher": "Canonical",<br/>  "sku": "server",<br/>  "version": "latest"<br/>}</pre> | no |
| <a name="input_bastion_os_type"></a> [bastion\_os\_type](#input\_bastion\_os\_type) | The operating system type for the Bastion VM. Options are 'linux' or 'windows'. | `string` | `"linux"` | no |
| <a name="input_bastion_private_ip_static"></a> [bastion\_private\_ip\_static](#input\_bastion\_private\_ip\_static) | Whether the Bastion Private IP should be Static (true) or Dynamic (false). | `bool` | `false` | no |
| <a name="input_bastion_public_ip_static"></a> [bastion\_public\_ip\_static](#input\_bastion\_public\_ip\_static) | Whether the Bastion Public IP should be Static (true) or Dynamic (false). | `bool` | `false` | no |
| <a name="input_bastion_sa_type"></a> [bastion\_sa\_type](#input\_bastion\_sa\_type) | Bastion OS disk storage type. | `string` | `"Standard_LRS"` | no |
| <a name="input_bastion_security_group_id"></a> [bastion\_security\_group\_id](#input\_bastion\_security\_group\_id) | ID for existing Security Group to be used for the bastion VM. Required when create\_bastion\_sg is false. | `string` | `null` | no |
| <a name="input_bastion_security_group_name"></a> [bastion\_security\_group\_name](#input\_bastion\_security\_group\_name) | Name of bastion Security Group for CDP environment. Required when create\_bastion\_sg is true. | `string` | `null` | no |
| <a name="input_bastion_size"></a> [bastion\_size](#input\_bastion\_size) | Bastion VM size. | `string` | `"Standard_B1s"` | no |
| <a name="input_bastion_user_data"></a> [bastion\_user\_data](#input\_bastion\_user\_data) | Base64-encoded user data for the bastion instance. | `string` | `null` | no |
| <a name="input_create_bastion_sg"></a> [create\_bastion\_sg](#input\_create\_bastion\_sg) | Flag to specify if the Security Group for the bastion should be created. | `bool` | `true` | no |
| <a name="input_disable_pwd_auth"></a> [disable\_pwd\_auth](#input\_disable\_pwd\_auth) | When an admin\_password is specified, disable\_password\_authentication must be set to false. | `bool` | `true` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of ingress rules to create. | <pre>list(object({<br/><br/>    rule_name          = string<br/>    description        = optional(string)<br/>    protocol           = string<br/>    src_port_range     = optional(string)<br/>    src_port_ranges    = optional(list(string))<br/>    dest_port_range    = optional(string)<br/>    dest_port_ranges   = optional(list(string))<br/>    src_addr_prefix    = optional(string)<br/>    src_addr_prefixes  = optional(list(string))<br/>    src_app_sg_ids     = optional(list(string))<br/>    dest_addr_prefix   = optional(string)<br/>    dest_addr_prefixes = optional(list(string))<br/>    dest_app_sg_ids    = optional(list(string))<br/>    priority           = number<br/>  }))</pre> | `[]` | no |
| <a name="input_public_key_text"></a> [public\_key\_text](#input\_public\_key\_text) | The SSH public key for accessing the Linux bastion. | `string` | `null` | no |
| <a name="input_replace_on_user_data_change"></a> [replace\_on\_user\_data\_change](#input\_replace\_on\_user\_data\_change) | Trigger a destroy and recreate the VM when user\_data changes. | `bool` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provised resources. | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_admin_username"></a> [bastion\_admin\_username](#output\_bastion\_admin\_username) | The administrator username for the bastion host. This is used to log in to the instance. |
| <a name="output_bastion_instance_details"></a> [bastion\_instance\_details](#output\_bastion\_instance\_details) | The details of the Bastion instance. |
| <a name="output_bastion_instance_id"></a> [bastion\_instance\_id](#output\_bastion\_instance\_id) | The ID of the Bastion instance. |
| <a name="output_bastion_instance_private_ip"></a> [bastion\_instance\_private\_ip](#output\_bastion\_instance\_private\_ip) | The private IP address of the Bastion instance. |
| <a name="output_bastion_instance_public_ip"></a> [bastion\_instance\_public\_ip](#output\_bastion\_instance\_public\_ip) | The public IP address of the Bastion instance. |
| <a name="output_linux_ssh_command"></a> [linux\_ssh\_command](#output\_linux\_ssh\_command) | For Linux, SSH command required to connect to the Bastion host using the admin username and the public IP address. |
<!-- END_TF_DOCS -->