<!-- BEGIN_TF_DOCS -->
# Terraform Module for Cloudera on Azure Environment Permissions

This module contains resource files and example variable definition files for creation of Azure Managed Identity and Role Assignments required for Cloudera on Azure.

## Usage

The [examples](./examples) directory has examples of Azure Resource Group creation:

* `ex01-minimal-inputs` uses the minimum set of inputs for the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.cdp_datalake_admin_backup_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_datalake_admin_data_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_datalake_admin_log_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_idbroker_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_log_data_access_backup_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_log_data_access_log_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_ranger_audit_backup_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_ranger_audit_data_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_ranger_audit_log_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_raz_data_storage_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.cdp_datalake_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.cdp_idbroker](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.cdp_log_data_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.cdp_ranger_audit_data_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.cdp_raz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Region which Cloud resources will be created | `string` | n/a | yes |
| <a name="input_backup_storage_container_id"></a> [backup\_storage\_container\_id](#input\_backup\_storage\_container\_id) | Resource Manager ID of the Backup Storage Container | `string` | n/a | yes |
| <a name="input_data_storage_container_id"></a> [data\_storage\_container\_id](#input\_data\_storage\_container\_id) | Resource Manager ID of the Data Storage Container | `string` | n/a | yes |
| <a name="input_datalake_admin_backup_container_role_assignments"></a> [datalake\_admin\_backup\_container\_role\_assignments](#input\_datalake\_admin\_backup\_container\_role\_assignments) | List of Role Assignments for the Datalake Admin Managed Identity assigned to the Backup Storage Container. | <pre>list(object({<br/>    role        = string<br/>    description = string<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_datalake_admin_data_container_role_assignments"></a> [datalake\_admin\_data\_container\_role\_assignments](#input\_datalake\_admin\_data\_container\_role\_assignments) | List of Role Assignments for the Datalake Admin Managed Identity assigned to the Data Storage Container. | <pre>list(object({<br/>    role        = string<br/>    description = string<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_datalake_admin_log_container_role_assignments"></a> [datalake\_admin\_log\_container\_role\_assignments](#input\_datalake\_admin\_log\_container\_role\_assignments) | List of Role Assignments for the Datalake Admin Managed Identity assigned to the Logs Storage Container. | <pre>list(object({<br/>    role        = string<br/>    description = string<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_datalake_admin_managed_identity_name"></a> [datalake\_admin\_managed\_identity\_name](#input\_datalake\_admin\_managed\_identity\_name) | Datalake Admin Managed Identity name | `string` | n/a | yes |
| <a name="input_enable_raz"></a> [enable\_raz](#input\_enable\_raz) | Flag to enable Ranger Authorization Service (RAZ) | `bool` | n/a | yes |
| <a name="input_idbroker_managed_identity_name"></a> [idbroker\_managed\_identity\_name](#input\_idbroker\_managed\_identity\_name) | IDBroker Managed Identity name | `string` | n/a | yes |
| <a name="input_idbroker_role_assignments"></a> [idbroker\_role\_assignments](#input\_idbroker\_role\_assignments) | List of Role Assignments for the IDBroker Managed Identity | <pre>list(object({<br/>    role        = string<br/>    description = string<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_log_data_access_managed_identity_name"></a> [log\_data\_access\_managed\_identity\_name](#input\_log\_data\_access\_managed\_identity\_name) | Log Data Access Managed Identity name | `string` | n/a | yes |
| <a name="input_log_data_access_role_assignments"></a> [log\_data\_access\_role\_assignments](#input\_log\_data\_access\_role\_assignments) | List of Role Assignments for the Log Data Access Managed Identity. | <pre>list(object({<br/>    role        = string<br/>    description = string<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_log_storage_container_id"></a> [log\_storage\_container\_id](#input\_log\_storage\_container\_id) | Resource Manager ID of the Log Storage Container | `string` | n/a | yes |
| <a name="input_ranger_audit_backup_container_role_assignments"></a> [ranger\_audit\_backup\_container\_role\_assignments](#input\_ranger\_audit\_backup\_container\_role\_assignments) | List of Role Assignments for the Ranger Audit Managed Identity assigned to the Backup Storage Container. | <pre>list(object({<br/>    role        = string<br/>    description = string<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_ranger_audit_data_access_managed_identity_name"></a> [ranger\_audit\_data\_access\_managed\_identity\_name](#input\_ranger\_audit\_data\_access\_managed\_identity\_name) | Ranger Audit Managed Identity name | `string` | n/a | yes |
| <a name="input_ranger_audit_data_container_role_assignments"></a> [ranger\_audit\_data\_container\_role\_assignments](#input\_ranger\_audit\_data\_container\_role\_assignments) | List of Role Assignments for the Ranger Audit Managed Identity assigned to the Data Storage Container. | <pre>list(object({<br/>    role        = string<br/>    description = string<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_ranger_audit_log_container_role_assignments"></a> [ranger\_audit\_log\_container\_role\_assignments](#input\_ranger\_audit\_log\_container\_role\_assignments) | List of Role Assignments for the Ranger Audit Managed Identity assigned to the Log Storage Container. | <pre>list(object({<br/>    role        = string<br/>    description = string<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_raz_managed_identity_name"></a> [raz\_managed\_identity\_name](#input\_raz\_managed\_identity\_name) | RAZ Managed Identity name | `string` | n/a | yes |
| <a name="input_raz_storage_role_assignments"></a> [raz\_storage\_role\_assignments](#input\_raz\_storage\_role\_assignments) | List of Role Assignments for the Ranger Audit Managed Identity assigned to the Log Storage Container. | <pre>list(object({<br/>    role        = string<br/>    description = string<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Azrue Resource Group for Managed Identities. | `string` | n/a | yes |
| <a name="input_backup_storage_account_id"></a> [backup\_storage\_account\_id](#input\_backup\_storage\_account\_id) | Resource Manager ID of the Backup Storage Account. Required only if RAZ is enabled. Not required if log storage is the same as data and log storage. | `string` | `null` | no |
| <a name="input_data_storage_account_id"></a> [data\_storage\_account\_id](#input\_data\_storage\_account\_id) | Resource Manager ID of the Data Storage Account. Required only if RAZ is enabled. | `string` | `null` | no |
| <a name="input_log_storage_account_id"></a> [log\_storage\_account\_id](#input\_log\_storage\_account\_id) | Resource Manager ID of the Log Storage Account. Required only if RAZ is enabled. Not required if log storage is the same as data storage. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provised resources | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_datalakeadmin_identity_id"></a> [azure\_datalakeadmin\_identity\_id](#output\_azure\_datalakeadmin\_identity\_id) | Datalake Admin Managed Identity ID |
| <a name="output_azure_idbroker_identity_id"></a> [azure\_idbroker\_identity\_id](#output\_azure\_idbroker\_identity\_id) | IDBroker Managed Identity ID |
| <a name="output_azure_log_identity_id"></a> [azure\_log\_identity\_id](#output\_azure\_log\_identity\_id) | Log Data Access Managed Identity ID |
| <a name="output_azure_ranger_audit_identity_id"></a> [azure\_ranger\_audit\_identity\_id](#output\_azure\_ranger\_audit\_identity\_id) | Ranger Audit Managed Identity ID |
| <a name="output_azure_raz_identity_id"></a> [azure\_raz\_identity\_id](#output\_azure\_raz\_identity\_id) | RAZ Managed Identity ID. Value returned if RAZ is enabled |
<!-- END_TF_DOCS -->