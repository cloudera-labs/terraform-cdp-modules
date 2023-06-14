<!-- BEGIN_TF_DOCS -->
# Terraform Module for CDP Prerequisites on Azure

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.39.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.45.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | 2.3.1 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.2.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.39.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.45.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.2.3 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.cdp_xaccount_app](https://registry.terraform.io/providers/hashicorp/azuread/2.39.0/docs/resources/application) | resource |
| [azuread_application_password.cdp_xaccount_app_password](https://registry.terraform.io/providers/hashicorp/azuread/2.39.0/docs/resources/application_password) | resource |
| [azuread_service_principal.cdp_xaccount_app_sp](https://registry.terraform.io/providers/hashicorp/azuread/2.39.0/docs/resources/service_principal) | resource |
| [azurerm_network_security_group.cdp_default_sg](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.cdp_knox_sg](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.cdp_default_sg_ingress_cdp_control_plane](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.cdp_default_sg_ingress_extra_access](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.cdp_knox_sg_ingress_cdp_control_plane](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.cdp_knox_sg_ingress_extra_access](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/network_security_rule) | resource |
| [azurerm_resource_group.cdp_rmgp](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.cdp_datalake_admin_backup_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_datalake_admin_data_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_datalake_admin_log_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_idbroker_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_log_data_access_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_ranger_audit_data_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_ranger_audit_log_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_raz_assign](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_xaccount_role](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.cdp_storage_locations](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/storage_account) | resource |
| [azurerm_storage_container.cdp_backup_storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.cdp_data_storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/storage_container) | resource |
| [azurerm_storage_container.cdp_log_storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/storage_container) | resource |
| [azurerm_subnet.cdp_private_subnets](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/subnet) | resource |
| [azurerm_subnet.cdp_public_subnets](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/subnet) | resource |
| [azurerm_user_assigned_identity.cdp_datalake_admin](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.cdp_idbroker](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.cdp_log_data_access](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.cdp_ranger_audit_data_access](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.cdp_raz](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/user_assigned_identity) | resource |
| [azurerm_virtual_network.cdp_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.45.0/docs/resources/virtual_network) | resource |
| [local_file.cdp_deployment_template](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/file) | resource |
| [random_id.bucket_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
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
| <a name="input_cdp_control_plane_cidrs"></a> [cdp\_control\_plane\_cidrs](#input\_cdp\_control\_plane\_cidrs) | CIDR for access to CDP Control Plane | `list(string)` | <pre>[<br>  "52.36.110.208/32",<br>  "52.40.165.49/32",<br>  "35.166.86.177/32"<br>]</pre> | no |
| <a name="input_cdp_control_plane_region"></a> [cdp\_control\_plane\_region](#input\_cdp\_control\_plane\_region) | CDP Control Plane Region | `string` | `"us-west-1"` | no |
| <a name="input_cdp_profile"></a> [cdp\_profile](#input\_cdp\_profile) | Profile for CDP credentials | `string` | `"default"` | no |
| <a name="input_data_storage"></a> [data\_storage](#input\_data\_storage) | Data storage locations for CDP environment | <pre>object({<br>    data_storage_bucket = string<br>    data_storage_object = string<br>  })</pre> | `null` | no |
| <a name="input_datalake_admin_backup_container_role_assignments"></a> [datalake\_admin\_backup\_container\_role\_assignments](#input\_datalake\_admin\_backup\_container\_role\_assignments) | List of Role Assignments for the Datalake Admin Managed Identity assigned to the Backup Storage Container. | <pre>list(object({<br>    role              = string<br>    description        = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Data Owner Role to Data Lake Admin Identity at Backup Container Level",<br>    "role": "Storage Blob Data Owner"<br>  }<br>]</pre> | no |
| <a name="input_datalake_admin_data_container_role_assignments"></a> [datalake\_admin\_data\_container\_role\_assignments](#input\_datalake\_admin\_data\_container\_role\_assignments) | List of Role Assignments for the Datalake Admin Managed Identity assigned to the Data Storage Container. | <pre>list(object({<br>    role              = string<br>    description        = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Data Owner Role to Data Lake Admin Identity at Data Container Level",<br>    "role": "Storage Blob Data Owner"<br>  }<br>]</pre> | no |
| <a name="input_datalake_admin_log_container_role_assignments"></a> [datalake\_admin\_log\_container\_role\_assignments](#input\_datalake\_admin\_log\_container\_role\_assignments) | List of Role Assignments for the Datalake Admin Managed Identity assigned to the Logs Storage Container. | <pre>list(object({<br>    role              = string<br>    description        = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Data Owner Role to Data Lake Admin Identity at Logs Container Level",<br>    "role": "Storage Blob Data Owner"<br>  }<br>]</pre> | no |
| <a name="input_datalake_admin_managed_identity_name"></a> [datalake\_admin\_managed\_identity\_name](#input\_datalake\_admin\_managed\_identity\_name) | Datalake Admin Managed Identity name | `string` | `null` | no |
| <a name="input_deploy_cdp"></a> [deploy\_cdp](#input\_deploy\_cdp) | Deploy the CDP environment as part of Terraform | `bool` | `true` | no |
| <a name="input_enable_raz"></a> [enable\_raz](#input\_enable\_raz) | Flag to enable Ranger Authorization Service (RAZ) | `bool` | `true` | no |
| <a name="input_env_tags"></a> [env\_tags](#input\_env\_tags) | Tags applied to provised resources | `map(any)` | `null` | no |
| <a name="input_idbroker_managed_identity_name"></a> [idbroker\_managed\_identity\_name](#input\_idbroker\_managed\_identity\_name) | IDBroker Managed Identity name | `string` | `null` | no |
| <a name="input_idbroker_role_assignments"></a> [idbroker\_role\_assignments](#input\_idbroker\_role\_assignments) | List of Role Assignments for the IDBroker Managed Identity | <pre>list(object({<br>    role              = string<br>    description        = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign VM Contributor Role to IDBroker Identity at Subscription Level",<br>    "role": "Virtual Machine Contributor"<br>  },<br>  {<br>    "description": "Assign Managed Identity Operator Role to IDBroker Identity at Subscription Level",<br>    "role": "Managed Identity Operator"<br>  }<br>]</pre> | no |
| <a name="input_infra_type"></a> [infra\_type](#input\_infra\_type) | Cloud Provider to deploy CDP. | `string` | `"azure"` | no |
| <a name="input_ingress_extra_cidrs_and_ports"></a> [ingress\_extra\_cidrs\_and\_ports](#input\_ingress\_extra\_cidrs\_and\_ports) | List of extra CIDR blocks and ports to include in Security Group Ingress rules | <pre>object({<br>    cidrs = list(string)<br>    ports = list(number)<br>  })</pre> | <pre>{<br>  "cidrs": [],<br>  "ports": []<br>}</pre> | no |
| <a name="input_log_data_access_managed_identity_name"></a> [log\_data\_access\_managed\_identity\_name](#input\_log\_data\_access\_managed\_identity\_name) | Log Data Access Managed Identity name | `string` | `null` | no |
| <a name="input_log_data_access_role_assignments"></a> [log\_data\_access\_role\_assignments](#input\_log\_data\_access\_role\_assignments) | List of Role Assignments for the Log Data Access Managed Identity. | <pre>list(object({<br>    role              = string<br>    description        = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Data Contributor Role to Log Role at Logs Container level",<br>    "role": "Storage Blob Data Contributor"<br>  }<br>]</pre> | no |
| <a name="input_log_storage"></a> [log\_storage](#input\_log\_storage) | Optional log locations for CDP environment. If not provided follow the data\_storage variable | <pre>object({<br>    log_storage_bucket = string<br>    log_storage_object = string<br>  })</pre> | `null` | no |
| <a name="input_random_id_for_bucket"></a> [random\_id\_for\_bucket](#input\_random\_id\_for\_bucket) | Create a random suffix for the Storage Account names | `bool` | `true` | no |
| <a name="input_ranger_audit_data_access_managed_identity_name"></a> [ranger\_audit\_data\_access\_managed\_identity\_name](#input\_ranger\_audit\_data\_access\_managed\_identity\_name) | Ranger Audit Managed Identity name | `string` | `null` | no |
| <a name="input_ranger_audit_data_container_role_assignments"></a> [ranger\_audit\_data\_container\_role\_assignments](#input\_ranger\_audit\_data\_container\_role\_assignments) | List of Role Assignments for the Ranger Audit Managed Identity assigned to the Data Storage Container. | <pre>list(object({<br>    role              = string<br>    description        = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Data Contributor Role to Ranger Audit Role at Data Container level",<br>    "role": "Storage Blob Data Contributor"<br>  }<br>]</pre> | no |
| <a name="input_ranger_audit_log_container_role_assignments"></a> [ranger\_audit\_log\_container\_role\_assignments](#input\_ranger\_audit\_log\_container\_role\_assignments) | List of Role Assignments for the Ranger Audit Managed Identity assigned to the Log Storage Container. | <pre>list(object({<br>    role              = string<br>    description        = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Data Contributor Role to Ranger Audit Role at Logs Container level",<br>    "role": "Storage Blob Data Contributor"<br>  }<br>]</pre> | no |
| <a name="input_raz_managed_identity_name"></a> [raz\_managed\_identity\_name](#input\_raz\_managed\_identity\_name) | RAZ Managed Identity name | `string` | `null` | no |
| <a name="input_raz_role_assignments"></a> [raz\_role\_assignments](#input\_raz\_role\_assignments) | List of Role Assignments for the RAZ Managed Identity. | <pre>list(object({<br>    role              = string<br>    description        = string<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "description": "Assign Storage Blob Delegator Role to RAZ Identity at Storage Account level",<br>    "role": "Storage Blob Delegator"<br>  },<br>  {<br>    "description": "Assign Storage Blob Data Owner Role to RAZ Identity at Storage Account level",<br>    "role": "Storage Blob Data Owner"<br>  }<br>]</pre> | no |
| <a name="input_resourcegroup_name"></a> [resourcegroup\_name](#input\_resourcegroup\_name) | Resource Group name | `string` | `null` | no |
| <a name="input_security_group_default_name"></a> [security\_group\_default\_name](#input\_security\_group\_default\_name) | Default Security Group for CDP environment | `string` | `null` | no |
| <a name="input_security_group_knox_name"></a> [security\_group\_knox\_name](#input\_security\_group\_knox\_name) | Knox Security Group for CDP environment | `string` | `null` | no |
| <a name="input_subnet_count"></a> [subnet\_count](#input\_subnet\_count) | Number of Subnets Required | `string` | `"3"` | no |
| <a name="input_vnet_cidr"></a> [vnet\_cidr](#input\_vnet\_cidr) | VNet CIDR Block | `string` | `"10.10.0.0/16"` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | VNet name | `string` | `null` | no |
| <a name="input_xaccount_app_name"></a> [xaccount\_app\_name](#input\_xaccount\_app\_name) | Cross account application name within Azure Active Directory | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->