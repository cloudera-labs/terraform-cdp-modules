<!-- BEGIN_TF_DOCS -->
# Terraform Module for CDP Prerequisites on Azure

This module contains resource files and example variable definition files for creation of the pre-requisite Azure cloud resources required for Cloudera Data Platform (CDP) Public Cloud.

## Usage

The [examples](./examples) directory has example Azure Cloud Service Provider deployments for different scenarios:

* `ex01-minimal-inputs` uses the minimum set of inputs for the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.39.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.45.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.39.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.45.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure_cdp_vnet"></a> [azure\_cdp\_vnet](#module\_azure\_cdp\_vnet) | ./modules/vnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_application.cdp_xaccount_app](https://registry.terraform.io/providers/hashicorp/azuread/2.39.0/docs/resources/application) | resource |
| [azuread_application_password.cdp_xaccount_app_password](https://registry.terraform.io/providers/hashicorp/azuread/2.39.0/docs/resources/application_password) | resource |
| [azuread_service_principal.cdp_xaccount_app_sp](https://registry.terraform.io/providers/hashicorp/azuread/2.39.0/docs/resources/service_principal) | resource |
| [azurerm_network_security_group.cdp_default_sg](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.cdp_knox_sg](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.cdp_default_sg_ingress_extra_access](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.cdp_knox_sg_ingress_extra_access](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/network_security_rule) | resource |
| [azurerm_resource_group.cdp_rmgp](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.cdp_datalake_admin_backup_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_datalake_admin_data_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_datalake_admin_log_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_idbroker_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_log_data_access_backup_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_log_data_access_log_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_ranger_audit_backup_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_ranger_audit_data_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_ranger_audit_log_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_raz_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_xaccount_role](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.cdp_storage_locations](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/storage_account) | resource |
| [azurerm_storage_container.cdp_backup_storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.cdp_data_storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.cdp_log_storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/storage_container) | resource |
| [azurerm_user_assigned_identity.cdp_datalake_admin](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.cdp_idbroker](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.cdp_log_data_access](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.cdp_ranger_audit_data_access](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.cdp_raz](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/user_assigned_identity) | resource |
| [random_id.bucket_suffix](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/id) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/2.39.0/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_template"></a> [deployment\_template](#input\_deployment\_template) | Deployment Pattern to use for Cloud resources and CDP | `string` | n/a | yes |
| <a name="input_env_prefix"></a> [env\_prefix](#input\_env\_prefix) | Shorthand name for the environment. Used in resource descriptions | `string` | n/a | yes |
| <a name="input_agent_source_tag"></a> [agent\_source\_tag](#input\_agent\_source\_tag) | Tag to identify deployment source | `map(any)` | <pre>{<br>  "agent_source": "tf-cdp-module"<br>}</pre> | no |
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Region which Cloud resources will be created | `string` | `null` | no |
| <a name="input_backup_storage"></a> [backup\_storage](#input\_backup\_storage) | Optional Backup location for CDP environment. If not provided follow the data\_storage variable | <pre>object({<br>    backup_storage_bucket = string<br>    backup_storage_object = string<br>  })</pre> | `null` | no |
| <a name="input_cdp_gw_subnet_names"></a> [cdp\_gw\_subnet\_names](#input\_cdp\_gw\_subnet\_names) | List of subnet names for CDP Gateway. Required if create\_vpc is false. | `list(any)` | `null` | no |
| <a name="input_cdp_subnet_names"></a> [cdp\_subnet\_names](#input\_cdp\_subnet\_names) | List of subnet names for CDP Resources. Required if create\_vpc is false. | `list(any)` | `null` | no |
| <a name="input_cdp_vnet_name"></a> [cdp\_vnet\_name](#input\_cdp\_vnet\_name) | Pre-existing VNet Name for CDP environment. Required if create\_vnet is false. | `string` | `null` | no |
| <a name="input_create_vnet"></a> [create\_vnet](#input\_create\_vnet) | Flag to specify if the VNet should be created | `bool` | `true` | no |
| <a name="input_data_storage"></a> [data\_storage](#input\_data\_storage) | Data storage locations for CDP environment | <pre>object({<br>    data_storage_bucket = string<br>    data_storage_object = string<br>  })</pre> | `null` | no |
| <a name="input_datalake_admin_backup_container_role_assignments"></a> [datalake\_admin\_backup\_container\_role\_assignments](#input\_datalake\_admin\_backup\_container\_role\_assignments) | List of Role Assignments for the Datalake Admin Managed Identity assigned to the Backup Storage Container. | <pre>list(object({<br>    role        = string<br>    description = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Data Owner Role to Data Lake Admin Identity at Backup Container Level",<br>    "role": "Storage Blob Data Owner"<br>  }<br>]</pre> | no |
| <a name="input_datalake_admin_data_container_role_assignments"></a> [datalake\_admin\_data\_container\_role\_assignments](#input\_datalake\_admin\_data\_container\_role\_assignments) | List of Role Assignments for the Datalake Admin Managed Identity assigned to the Data Storage Container. | <pre>list(object({<br>    role        = string<br>    description = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Data Owner Role to Data Lake Admin Identity at Data Container Level",<br>    "role": "Storage Blob Data Owner"<br>  }<br>]</pre> | no |
| <a name="input_datalake_admin_log_container_role_assignments"></a> [datalake\_admin\_log\_container\_role\_assignments](#input\_datalake\_admin\_log\_container\_role\_assignments) | List of Role Assignments for the Datalake Admin Managed Identity assigned to the Logs Storage Container. | <pre>list(object({<br>    role        = string<br>    description = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Data Owner Role to Data Lake Admin Identity at Logs Container Level",<br>    "role": "Storage Blob Data Owner"<br>  }<br>]</pre> | no |
| <a name="input_datalake_admin_managed_identity_name"></a> [datalake\_admin\_managed\_identity\_name](#input\_datalake\_admin\_managed\_identity\_name) | Datalake Admin Managed Identity name | `string` | `null` | no |
| <a name="input_enable_raz"></a> [enable\_raz](#input\_enable\_raz) | Flag to enable Ranger Authorization Service (RAZ) | `bool` | `true` | no |
| <a name="input_env_tags"></a> [env\_tags](#input\_env\_tags) | Tags applied to provisioned resources | `map(any)` | `null` | no |
| <a name="input_idbroker_managed_identity_name"></a> [idbroker\_managed\_identity\_name](#input\_idbroker\_managed\_identity\_name) | IDBroker Managed Identity name | `string` | `null` | no |
| <a name="input_idbroker_role_assignments"></a> [idbroker\_role\_assignments](#input\_idbroker\_role\_assignments) | List of Role Assignments for the IDBroker Managed Identity | <pre>list(object({<br>    role        = string<br>    description = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign VM Contributor Role to IDBroker Identity at Subscription Level",<br>    "role": "Virtual Machine Contributor"<br>  },<br>  {<br>    "description": "Assign Managed Identity Operator Role to IDBroker Identity at Subscription Level",<br>    "role": "Managed Identity Operator"<br>  }<br>]</pre> | no |
| <a name="input_ingress_extra_cidrs_and_ports"></a> [ingress\_extra\_cidrs\_and\_ports](#input\_ingress\_extra\_cidrs\_and\_ports) | List of extra CIDR blocks and ports to include in Security Group Ingress rules | <pre>object({<br>    cidrs = list(string)<br>    ports = list(number)<br>  })</pre> | <pre>{<br>  "cidrs": [],<br>  "ports": []<br>}</pre> | no |
| <a name="input_log_data_access_managed_identity_name"></a> [log\_data\_access\_managed\_identity\_name](#input\_log\_data\_access\_managed\_identity\_name) | Log Data Access Managed Identity name | `string` | `null` | no |
| <a name="input_log_data_access_role_assignments"></a> [log\_data\_access\_role\_assignments](#input\_log\_data\_access\_role\_assignments) | List of Role Assignments for the Log Data Access Managed Identity. | <pre>list(object({<br>    role        = string<br>    description = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Data Contributor Role to Log Role at Logs and Backup Container level",<br>    "role": "Storage Blob Data Contributor"<br>  }<br>]</pre> | no |
| <a name="input_log_storage"></a> [log\_storage](#input\_log\_storage) | Optional log locations for CDP environment. If not provided follow the data\_storage variable | <pre>object({<br>    log_storage_bucket = string<br>    log_storage_object = string<br>  })</pre> | `null` | no |
| <a name="input_random_id_for_bucket"></a> [random\_id\_for\_bucket](#input\_random\_id\_for\_bucket) | Create a random suffix for the Storage Account names | `bool` | `true` | no |
| <a name="input_ranger_audit_backup_container_role_assignments"></a> [ranger\_audit\_backup\_container\_role\_assignments](#input\_ranger\_audit\_backup\_container\_role\_assignments) | List of Role Assignments for the Ranger Audit Managed Identity assigned to the Backup Storage Container. | <pre>list(object({<br>    role        = string<br>    description = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Data Contributor Role to Ranger Audit Role at Backup Container level",<br>    "role": "Storage Blob Data Contributor"<br>  }<br>]</pre> | no |
| <a name="input_ranger_audit_data_access_managed_identity_name"></a> [ranger\_audit\_data\_access\_managed\_identity\_name](#input\_ranger\_audit\_data\_access\_managed\_identity\_name) | Ranger Audit Managed Identity name | `string` | `null` | no |
| <a name="input_ranger_audit_data_container_role_assignments"></a> [ranger\_audit\_data\_container\_role\_assignments](#input\_ranger\_audit\_data\_container\_role\_assignments) | List of Role Assignments for the Ranger Audit Managed Identity assigned to the Data Storage Container. | <pre>list(object({<br>    role        = string<br>    description = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Data Contributor Role to Ranger Audit Role at Data Container level",<br>    "role": "Storage Blob Data Contributor"<br>  }<br>]</pre> | no |
| <a name="input_ranger_audit_log_container_role_assignments"></a> [ranger\_audit\_log\_container\_role\_assignments](#input\_ranger\_audit\_log\_container\_role\_assignments) | List of Role Assignments for the Ranger Audit Managed Identity assigned to the Log Storage Container. | <pre>list(object({<br>    role        = string<br>    description = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Data Contributor Role to Ranger Audit Role at Logs Container level",<br>    "role": "Storage Blob Data Contributor"<br>  }<br>]</pre> | no |
| <a name="input_raz_managed_identity_name"></a> [raz\_managed\_identity\_name](#input\_raz\_managed\_identity\_name) | RAZ Managed Identity name | `string` | `null` | no |
| <a name="input_raz_storage_role_assignments"></a> [raz\_storage\_role\_assignments](#input\_raz\_storage\_role\_assignments) | List of Role Assignments for the Ranger Audit Managed Identity assigned to the Log Storage Container. | <pre>list(object({<br>    role        = string<br>    description = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Delegator Role to RAZ Identity at Storage Account level",<br>    "role": "Storage Blob Delegator"<br>  },<br>  {<br>    "description": "Assign Storage Blob Data Owner Role to RAZ Identity at Storage Account level",<br>    "role": "Storage Blob Data Owner"<br>  }<br>]</pre> | no |
| <a name="input_resourcegroup_name"></a> [resourcegroup\_name](#input\_resourcegroup\_name) | Resource Group name | `string` | `null` | no |
| <a name="input_security_group_default_name"></a> [security\_group\_default\_name](#input\_security\_group\_default\_name) | Default Security Group for CDP environment | `string` | `null` | no |
| <a name="input_security_group_knox_name"></a> [security\_group\_knox\_name](#input\_security\_group\_knox\_name) | Knox Security Group for CDP environment | `string` | `null` | no |
| <a name="input_subnet_count"></a> [subnet\_count](#input\_subnet\_count) | Number of Subnets Required | `string` | `"3"` | no |
| <a name="input_vnet_cidr"></a> [vnet\_cidr](#input\_vnet\_cidr) | VNet CIDR Block | `string` | `"10.10.0.0/16"` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | VNet name | `string` | `null` | no |
| <a name="input_xaccount_app_name"></a> [xaccount\_app\_name](#input\_xaccount\_app\_name) | Cross account application name within Azure Active Directory | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_backup_storage_account"></a> [azure\_backup\_storage\_account](#output\_azure\_backup\_storage\_account) | Azure backup storage account name |
| <a name="output_azure_backup_storage_container"></a> [azure\_backup\_storage\_container](#output\_azure\_backup\_storage\_container) | Azure backup storage container name |
| <a name="output_azure_backup_storage_location"></a> [azure\_backup\_storage\_location](#output\_azure\_backup\_storage\_location) | Azure backup storage location |
| <a name="output_azure_cdp_gateway_subnet_names"></a> [azure\_cdp\_gateway\_subnet\_names](#output\_azure\_cdp\_gateway\_subnet\_names) | Azure Virtual Subnet Names for CDP Endpoint Access Gateway |
| <a name="output_azure_cdp_subnet_names"></a> [azure\_cdp\_subnet\_names](#output\_azure\_cdp\_subnet\_names) | Azure Virtual Subnet Names for CDP Resources |
| <a name="output_azure_data_storage_account"></a> [azure\_data\_storage\_account](#output\_azure\_data\_storage\_account) | Azure data storage account name |
| <a name="output_azure_data_storage_container"></a> [azure\_data\_storage\_container](#output\_azure\_data\_storage\_container) | Azure data storage container name |
| <a name="output_azure_data_storage_location"></a> [azure\_data\_storage\_location](#output\_azure\_data\_storage\_location) | Azure data storage location |
| <a name="output_azure_datalakeadmin_identity_id"></a> [azure\_datalakeadmin\_identity\_id](#output\_azure\_datalakeadmin\_identity\_id) | Datalake Admin Managed Identity ID |
| <a name="output_azure_idbroker_identity_id"></a> [azure\_idbroker\_identity\_id](#output\_azure\_idbroker\_identity\_id) | IDBroker Managed Identity ID |
| <a name="output_azure_log_identity_id"></a> [azure\_log\_identity\_id](#output\_azure\_log\_identity\_id) | Log Data Access Managed Identity ID |
| <a name="output_azure_log_storage_account"></a> [azure\_log\_storage\_account](#output\_azure\_log\_storage\_account) | Azure log storage account name |
| <a name="output_azure_log_storage_container"></a> [azure\_log\_storage\_container](#output\_azure\_log\_storage\_container) | Azure log storage container name |
| <a name="output_azure_log_storage_location"></a> [azure\_log\_storage\_location](#output\_azure\_log\_storage\_location) | Azure log storage location |
| <a name="output_azure_ranger_audit_identity_id"></a> [azure\_ranger\_audit\_identity\_id](#output\_azure\_ranger\_audit\_identity\_id) | Ranger Audit Managed Identity ID |
| <a name="output_azure_raz_identity_id"></a> [azure\_raz\_identity\_id](#output\_azure\_raz\_identity\_id) | RAZ Managed Identity ID. Value returned if RAZ is enabled |
| <a name="output_azure_resource_group_name"></a> [azure\_resource\_group\_name](#output\_azure\_resource\_group\_name) | Azure Resource Group Name |
| <a name="output_azure_security_group_default_uri"></a> [azure\_security\_group\_default\_uri](#output\_azure\_security\_group\_default\_uri) | Azure Default Security Group URI |
| <a name="output_azure_security_group_knox_uri"></a> [azure\_security\_group\_knox\_uri](#output\_azure\_security\_group\_knox\_uri) | Azure Knox Security Group URI |
| <a name="output_azure_subscription_id"></a> [azure\_subscription\_id](#output\_azure\_subscription\_id) | Subscription ID where the Azure pre-reqs are created |
| <a name="output_azure_tenant_id"></a> [azure\_tenant\_id](#output\_azure\_tenant\_id) | Tenant ID where the Azure pre-reqs are created |
| <a name="output_azure_vnet_name"></a> [azure\_vnet\_name](#output\_azure\_vnet\_name) | Azure Virtual Network Name |
| <a name="output_azure_xaccount_app_pword"></a> [azure\_xaccount\_app\_pword](#output\_azure\_xaccount\_app\_pword) | Password for the Azure AD Cross Account Application |
| <a name="output_azure_xaccount_app_uuid"></a> [azure\_xaccount\_app\_uuid](#output\_azure\_xaccount\_app\_uuid) | UUID for the Azure AD Cross Account Application |
<!-- END_TF_DOCS -->