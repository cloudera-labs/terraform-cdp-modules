<!-- BEGIN_TF_DOCS -->
# Terraform Module for CDP Deployment

This module contains resource files and example variable definition files for deployment of Cloudera Data Platform (CDP) Public Cloud environment and Datalake creation on AWS, Azure or GCP.

## Usage

The [examples](./examples) directory has example CDP deployments:

* `ex01-aws-basic` creates a basic CDP deployment on AWS. This example makes use of the [terraform-cdp-aws-pre-reqs module](../terraform-cdp-aws-pre-reqs) to create the required cloud resources.

* `ex02-azure-basic` creates a basic CDP deployment on Azure. This example makes use of the [terraform-cdp-azure-pre-reqs module](../terraform-cdp-azure-pre-reqs) to create the required cloud resources.

* `ex02-gcp-basic` creates a basic CDP deployment on GCP. This example makes use of the [terraform-cdp-gcp-pre-reqs module](../terraform-cdp-gcp-pre-reqs) to create the required cloud resources.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_cdp"></a> [cdp](#requirement\_cdp) | >= 0.6.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cdp_on_aws"></a> [cdp\_on\_aws](#module\_cdp\_on\_aws) | ./modules/aws | n/a |
| <a name="module_cdp_on_azure"></a> [cdp\_on\_azure](#module\_cdp\_on\_azure) | ./modules/azure | n/a |
| <a name="module_cdp_on_gcp"></a> [cdp\_on\_gcp](#module\_cdp\_on\_gcp) | ./modules/gcp | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_storage_location"></a> [backup\_storage\_location](#input\_backup\_storage\_location) | Backup storage location. The location has to be in uri format for the cloud provider - i.e. s3a:// for AWS, abfs:// for Azure,  gs:// | `string` | n/a | yes |
| <a name="input_data_storage_location"></a> [data\_storage\_location](#input\_data\_storage\_location) | Data storage location. The location has to be in uri format for the cloud provider - i.e. s3a:// for AWS, abfs:// for Azure,  gs:// | `string` | n/a | yes |
| <a name="input_deployment_template"></a> [deployment\_template](#input\_deployment\_template) | Deployment Pattern to use for Cloud resources and CDP | `string` | n/a | yes |
| <a name="input_env_prefix"></a> [env\_prefix](#input\_env\_prefix) | Shorthand name for the environment. Used in CDP resource descriptions. This will be used to construct the value of where any of the CDP resource variables (e.g. environment\_name, cdp\_iam\_admin\_group\_name) are not defined. | `string` | n/a | yes |
| <a name="input_infra_type"></a> [infra\_type](#input\_infra\_type) | Cloud Provider to deploy CDP. | `string` | n/a | yes |
| <a name="input_log_storage_location"></a> [log\_storage\_location](#input\_log\_storage\_location) | Log storage location. The location has to be in uri format for the cloud provider - i.e. s3a:// for AWS, abfs:// for Azure,  gs:// | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region which cloud resources will be created | `string` | n/a | yes |
| <a name="input_agent_source_tag"></a> [agent\_source\_tag](#input\_agent\_source\_tag) | Tag to identify deployment source | `map(any)` | <pre>{<br>  "agent_source": "tf-cdp-module"<br>}</pre> | no |
| <a name="input_aws_datalake_admin_role_arn"></a> [aws\_datalake\_admin\_role\_arn](#input\_aws\_datalake\_admin\_role\_arn) | Datalake Admin Role ARN. Required for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_aws_idbroker_instance_profile_arn"></a> [aws\_idbroker\_instance\_profile\_arn](#input\_aws\_idbroker\_instance\_profile\_arn) | IDBroker Instance Profile ARN. Required for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_aws_log_instance_profile_arn"></a> [aws\_log\_instance\_profile\_arn](#input\_aws\_log\_instance\_profile\_arn) | Log Instance Profile ARN. Required for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_aws_private_subnet_ids"></a> [aws\_private\_subnet\_ids](#input\_aws\_private\_subnet\_ids) | List of private subnet ids. Required for CDP deployment on AWS. | `list(string)` | `null` | no |
| <a name="input_aws_public_subnet_ids"></a> [aws\_public\_subnet\_ids](#input\_aws\_public\_subnet\_ids) | List of public subnet ids. Required for CDP deployment on AWS. | `list(string)` | `null` | no |
| <a name="input_aws_ranger_audit_role_arn"></a> [aws\_ranger\_audit\_role\_arn](#input\_aws\_ranger\_audit\_role\_arn) | Ranger Audit Role ARN. Required for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_aws_raz_role_arn"></a> [aws\_raz\_role\_arn](#input\_aws\_raz\_role\_arn) | ARN for Ranger Authorization Service (RAZ) role. Only applicable for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_aws_security_access_cidr"></a> [aws\_security\_access\_cidr](#input\_aws\_security\_access\_cidr) | CIDR range for inbound traffic. With this option security groups will be automatically created. Only used for CDP deployment on AWS. Note it is recommended to specify pre-existing security groups instead of this option. | `string` | `null` | no |
| <a name="input_aws_security_group_default_id"></a> [aws\_security\_group\_default\_id](#input\_aws\_security\_group\_default\_id) | ID of the Default Security Group for CDP environment. Required for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_aws_security_group_knox_id"></a> [aws\_security\_group\_knox\_id](#input\_aws\_security\_group\_knox\_id) | ID of the Knox Security Group for CDP environment. Required for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_aws_vpc_id"></a> [aws\_vpc\_id](#input\_aws\_vpc\_id) | AWS Virtual Private Network ID. Required for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_aws_xaccount_role_arn"></a> [aws\_xaccount\_role\_arn](#input\_aws\_xaccount\_role\_arn) | Cross Account Role ARN. Required for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_azure_accept_image_terms"></a> [azure\_accept\_image\_terms](#input\_azure\_accept\_image\_terms) | Flag to automatically accept Azure Marketplace image terms during CDP cluster deployment. | `bool` | `true` | no |
| <a name="input_azure_aks_private_dns_zone_id"></a> [azure\_aks\_private\_dns\_zone\_id](#input\_azure\_aks\_private\_dns\_zone\_id) | The ID of an existing private DNS zone used for the AKS. | `string` | `null` | no |
| <a name="input_azure_cdp_gateway_subnet_names"></a> [azure\_cdp\_gateway\_subnet\_names](#input\_azure\_cdp\_gateway\_subnet\_names) | List of Azure Subnet Names CDP Endpoint Access Gateway. Required for CDP deployment on Azure. | `list(any)` | `null` | no |
| <a name="input_azure_cdp_subnet_names"></a> [azure\_cdp\_subnet\_names](#input\_azure\_cdp\_subnet\_names) | List of Azure Subnet Names for CDP Resources. Required for CDP deployment on Azure. | `list(any)` | `null` | no |
| <a name="input_azure_create_private_endpoints"></a> [azure\_create\_private\_endpoints](#input\_azure\_create\_private\_endpoints) | Flag to specify that Azure Postgres will be configured with Private Endpoint and a Private DNS Zone. | `bool` | `null` | no |
| <a name="input_azure_database_private_dns_zone_id"></a> [azure\_database\_private\_dns\_zone\_id](#input\_azure\_database\_private\_dns\_zone\_id) | The ID of an existing private DNS zone used for the database. | `string` | `null` | no |
| <a name="input_azure_datalake_flexible_server_delegated_subnet_name"></a> [azure\_datalake\_flexible\_server\_delegated\_subnet\_name](#input\_azure\_datalake\_flexible\_server\_delegated\_subnet\_name) | The subnet ID for the subnet within which you want to configure your Azure Flexible Server for the CDP datalake | `string` | `null` | no |
| <a name="input_azure_datalakeadmin_identity_id"></a> [azure\_datalakeadmin\_identity\_id](#input\_azure\_datalakeadmin\_identity\_id) | Datalake Admin Managed Identity ID. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_environment_flexible_server_delegated_subnet_names"></a> [azure\_environment\_flexible\_server\_delegated\_subnet\_names](#input\_azure\_environment\_flexible\_server\_delegated\_subnet\_names) | List of Azure Subnet Names delegated for Private Flexible servers. Required for CDP deployment on Azure. | `list(any)` | `null` | no |
| <a name="input_azure_idbroker_identity_id"></a> [azure\_idbroker\_identity\_id](#input\_azure\_idbroker\_identity\_id) | IDBroker Managed Identity ID. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_load_balancer_sku"></a> [azure\_load\_balancer\_sku](#input\_azure\_load\_balancer\_sku) | The Azure load balancer SKU type. Possible values are BASIC, STANDARD or None. The current default is BASIC. To disable the load balancer, use type NONE. | `string` | `null` | no |
| <a name="input_azure_log_identity_id"></a> [azure\_log\_identity\_id](#input\_azure\_log\_identity\_id) | Log Data Access Managed Identity ID. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_ranger_audit_identity_id"></a> [azure\_ranger\_audit\_identity\_id](#input\_azure\_ranger\_audit\_identity\_id) | Ranger Audit Managed Identity ID. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_raz_identity_id"></a> [azure\_raz\_identity\_id](#input\_azure\_raz\_identity\_id) | RAZ Managed Identity ID. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_resource_group_name"></a> [azure\_resource\_group\_name](#input\_azure\_resource\_group\_name) | Azure Resource Group name. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_security_access_cidr"></a> [azure\_security\_access\_cidr](#input\_azure\_security\_access\_cidr) | CIDR range for inbound traffic. With this option security groups will be automatically created. Only used for CDP deployment on Azure. Note it is recommended to specify pre-existing security groups instead of this option. | `string` | `null` | no |
| <a name="input_azure_security_group_default_uri"></a> [azure\_security\_group\_default\_uri](#input\_azure\_security\_group\_default\_uri) | Azure Default Security Group URI. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_security_group_knox_uri"></a> [azure\_security\_group\_knox\_uri](#input\_azure\_security\_group\_knox\_uri) | Azure Knox Security Group URI. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Subscription ID where the Azure pre-reqs are created. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | Tenant ID where the Azure pre-reqs are created. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_vnet_name"></a> [azure\_vnet\_name](#input\_azure\_vnet\_name) | Azure Virtual Network ID. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_xaccount_app_pword"></a> [azure\_xaccount\_app\_pword](#input\_azure\_xaccount\_app\_pword) | Password for the Azure AD Cross Account Application. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_xaccount_app_uuid"></a> [azure\_xaccount\_app\_uuid](#input\_azure\_xaccount\_app\_uuid) | UUID for the Azure AD Cross Account Application. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_cdp_admin_group_name"></a> [cdp\_admin\_group\_name](#input\_cdp\_admin\_group\_name) | Name of the CDP IAM Admin Group associated with the environment. Defaults to '<env\_prefix>-cdp-admin-group' if not specified. | `string` | `null` | no |
| <a name="input_cdp_user_group_name"></a> [cdp\_user\_group\_name](#input\_cdp\_user\_group\_name) | Name of the CDP IAM User Group associated with the environment. Defaults to '<env\_prefix>-cdp-user-group' if not specified. | `string` | `null` | no |
| <a name="input_cdp_xacccount_credential_name"></a> [cdp\_xacccount\_credential\_name](#input\_cdp\_xacccount\_credential\_name) | Name of the CDP Cross Account Credential. Defaults to '<env\_prefix>-xaccount-cred' if not specified. If create\_cdp\_credential is set to false then this should should be a valid pre-existing credential. | `string` | `null` | no |
| <a name="input_create_cdp_credential"></a> [create\_cdp\_credential](#input\_create\_cdp\_credential) | Flag to specify if the CDP Cross Account Credential should be created. If set to false then cdp\_xacccount\_credential\_name should be a valid pre-existing credential. | `bool` | `true` | no |
| <a name="input_datalake_async_creation"></a> [datalake\_async\_creation](#input\_datalake\_async\_creation) | Flag to specify if Terraform should wait for CDP datalake resource creation/deletion | `bool` | `false` | no |
| <a name="input_datalake_call_failure_threshold"></a> [datalake\_call\_failure\_threshold](#input\_datalake\_call\_failure\_threshold) | Threshold value that specifies how many times should a single CDP Datalake API call failure happen before giving up the polling | `number` | `3` | no |
| <a name="input_datalake_image"></a> [datalake\_image](#input\_datalake\_image) | The image to use for the datalake. Can only be used when the 'datalake\_version' parameter is set to null. You can use 'catalog' name and/or 'id' for selecting an image. | <pre>object({<br>    id           = optional(string)<br>    catalog_name = optional(string)<br>    os           = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_datalake_java_version"></a> [datalake\_java\_version](#input\_datalake\_java\_version) | The Java major version to use on the datalake cluster. | `number` | `null` | no |
| <a name="input_datalake_name"></a> [datalake\_name](#input\_datalake\_name) | Name of the CDP datalake. Defaults to '<env\_prefix>-<aw\|az\|gc\|>-dl' if not specified. | `string` | `null` | no |
| <a name="input_datalake_polling_timeout"></a> [datalake\_polling\_timeout](#input\_datalake\_polling\_timeout) | Timeout value in minutes for how long to poll for CDP datalake resource creation/deletion | `number` | `90` | no |
| <a name="input_datalake_recipes"></a> [datalake\_recipes](#input\_datalake\_recipes) | Additional recipes that will be attached on the datalake instances | <pre>set(<br>    object({<br>      instance_group_name = string,<br>      recipe_names        = set(string)<br>    })<br>  )</pre> | `null` | no |
| <a name="input_datalake_scale"></a> [datalake\_scale](#input\_datalake\_scale) | The scale of the datalake. Valid values are LIGHT\_DUTY, ENTERPRISE. | `string` | `null` | no |
| <a name="input_datalake_version"></a> [datalake\_version](#input\_datalake\_version) | The Datalake Runtime version. Valid values are latest or a semantic version, e.g. 7.2.17 | `string` | `"latest"` | no |
| <a name="input_enable_ccm_tunnel"></a> [enable\_ccm\_tunnel](#input\_enable\_ccm\_tunnel) | Flag to enable Cluster Connectivity Manager tunnel. If false then access from Cloud to CDP Control Plane CIDRs is required from via SG ingress | `bool` | `true` | no |
| <a name="input_enable_outbound_load_balancer"></a> [enable\_outbound\_load\_balancer](#input\_enable\_outbound\_load\_balancer) | Create outbound load balancers for Azure environments. Only applicable for CDP deployment on Azure. | `bool` | `null` | no |
| <a name="input_enable_raz"></a> [enable\_raz](#input\_enable\_raz) | Flag to enable Ranger Authorization Service (RAZ) | `bool` | `true` | no |
| <a name="input_encryption_at_host"></a> [encryption\_at\_host](#input\_encryption\_at\_host) | Provision resources with host encryption enabled. Only applicable for CDP deployment on Azure. | `bool` | `null` | no |
| <a name="input_encryption_key_arn"></a> [encryption\_key\_arn](#input\_encryption\_key\_arn) | ARN of the AWS KMS CMK to use for the server-side encryption of AWS storage resources. Only applicable for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_encryption_key_resource_group_name"></a> [encryption\_key\_resource\_group\_name](#input\_encryption\_key\_resource\_group\_name) | Name of the existing Azure resource group hosting the Azure Key Vault containing customer managed key which will be used to encrypt the Azure Managed Disk. Only applicable for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_encryption_key_url"></a> [encryption\_key\_url](#input\_encryption\_key\_url) | URL of the key which will be used to encrypt the Azure Managed Disks. Only applicable for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_encryption_user_managed_identity"></a> [encryption\_user\_managed\_identity](#input\_encryption\_user\_managed\_identity) | Managed Identity ID for encryption | `string` | `""` | no |
| <a name="input_endpoint_access_scheme"></a> [endpoint\_access\_scheme](#input\_endpoint\_access\_scheme) | The scheme for the workload endpoint gateway. PUBLIC creates an external endpoint that can be accessed over the Internet. PRIVATE which restricts the traffic to be internal to the VPC / Vnet. Relevant in Private Networks. | `string` | `null` | no |
| <a name="input_env_tags"></a> [env\_tags](#input\_env\_tags) | Tags applied to provisioned resources | `map(any)` | `null` | no |
| <a name="input_environment_async_creation"></a> [environment\_async\_creation](#input\_environment\_async\_creation) | Flag to specify if Terraform should wait for CDP environment resource creation/deletion | `bool` | `false` | no |
| <a name="input_environment_call_failure_threshold"></a> [environment\_call\_failure\_threshold](#input\_environment\_call\_failure\_threshold) | Threshold value that specifies how many times should a single CDP Environment API call failure happen before giving up the polling | `number` | `3` | no |
| <a name="input_environment_cascading_delete"></a> [environment\_cascading\_delete](#input\_environment\_cascading\_delete) | Flag to enable cascading delete of environment and associated resources | `bool` | `null` | no |
| <a name="input_environment_description"></a> [environment\_description](#input\_environment\_description) | Description of CDP environment | `string` | `null` | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Name of the CDP environment. Defaults to '<env\_prefix>-cdp-env' if not specified. | `string` | `null` | no |
| <a name="input_environment_polling_timeout"></a> [environment\_polling\_timeout](#input\_environment\_polling\_timeout) | Timeout value in minutes for how long to poll for CDP Environment resource creation/deletion | `number` | `60` | no |
| <a name="input_freeipa_catalog"></a> [freeipa\_catalog](#input\_freeipa\_catalog) | Image catalog to use for FreeIPA image selection | `string` | `null` | no |
| <a name="input_freeipa_image_id"></a> [freeipa\_image\_id](#input\_freeipa\_image\_id) | Image ID to use for creating FreeIPA instances | `string` | `null` | no |
| <a name="input_freeipa_instance_type"></a> [freeipa\_instance\_type](#input\_freeipa\_instance\_type) | Instance Type to use for creating FreeIPA instances | `string` | `null` | no |
| <a name="input_freeipa_instances"></a> [freeipa\_instances](#input\_freeipa\_instances) | The number of FreeIPA instances to create in the environment | `number` | `3` | no |
| <a name="input_freeipa_os"></a> [freeipa\_os](#input\_freeipa\_os) | The Operating System to be used for the FreeIPA instances | `string` | `null` | no |
| <a name="input_freeipa_recipes"></a> [freeipa\_recipes](#input\_freeipa\_recipes) | The recipes for the FreeIPA cluster | `set(string)` | `null` | no |
| <a name="input_gcp_availability_zones"></a> [gcp\_availability\_zones](#input\_gcp\_availability\_zones) | The zones of the environment in the given region. Multi-zone selection is not supported in GCP yet. It accepts only one zone until support is added. | `list(string)` | `null` | no |
| <a name="input_gcp_cdp_subnet_names"></a> [gcp\_cdp\_subnet\_names](#input\_gcp\_cdp\_subnet\_names) | List of GCP Subnet Names for CDP Resources. Required for CDP deployment on GCP. | `list(any)` | `null` | no |
| <a name="input_gcp_datalake_admin_service_account_email"></a> [gcp\_datalake\_admin\_service\_account\_email](#input\_gcp\_datalake\_admin\_service\_account\_email) | Email id of the service account for Datalake Admin. Required for CDP deployment on GCP. | `string` | `null` | no |
| <a name="input_gcp_encryption_key"></a> [gcp\_encryption\_key](#input\_gcp\_encryption\_key) | Key Resource ID of the customer managed encryption key to encrypt GCP resources. Only applicable for CDP deployment on GCP. | `string` | `null` | no |
| <a name="input_gcp_firewall_default_id"></a> [gcp\_firewall\_default\_id](#input\_gcp\_firewall\_default\_id) | Default Firewall for CDP environment.  Required for CDP deployment on GCP. | `string` | `null` | no |
| <a name="input_gcp_firewall_knox_id"></a> [gcp\_firewall\_knox\_id](#input\_gcp\_firewall\_knox\_id) | Knox Firewall for CDP environment. Required for CDP deployment on GCP. | `string` | `null` | no |
| <a name="input_gcp_idbroker_service_account_email"></a> [gcp\_idbroker\_service\_account\_email](#input\_gcp\_idbroker\_service\_account\_email) | Email id of the service account for IDBroker. Required for CDP deployment on GCP. | `string` | `null` | no |
| <a name="input_gcp_log_service_account_email"></a> [gcp\_log\_service\_account\_email](#input\_gcp\_log\_service\_account\_email) | Email id of the service account for Log Storage. Required for CDP deployment on GCP. | `string` | `null` | no |
| <a name="input_gcp_network_name"></a> [gcp\_network\_name](#input\_gcp\_network\_name) | GCP Network VPC name. Required for CDP deployment on GCP. | `string` | `null` | no |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | GCP project to deploy CDP environment. Required for CDP deployment on GCP. | `string` | `null` | no |
| <a name="input_gcp_ranger_audit_service_account_email"></a> [gcp\_ranger\_audit\_service\_account\_email](#input\_gcp\_ranger\_audit\_service\_account\_email) | Email id of the service account for Ranger Audit. Required for CDP deployment on GCP. | `string` | `null` | no |
| <a name="input_gcp_raz_service_account_email"></a> [gcp\_raz\_service\_account\_email](#input\_gcp\_raz\_service\_account\_email) | Email id of the service account for Ranger Authorization Service (RAZ). Only applicable for CDP deployment on GCP. | `string` | `null` | no |
| <a name="input_gcp_xaccount_service_account_private_key"></a> [gcp\_xaccount\_service\_account\_private\_key](#input\_gcp\_xaccount\_service\_account\_private\_key) | Base64 encoded private key of the GCP Cross Account Service Account Key. Required for CDP deployment on GCP. | `string` | `null` | no |
| <a name="input_keypair_name"></a> [keypair\_name](#input\_keypair\_name) | SSH Keypair name in Cloud Service Provider. For CDP deployment on AWS, either 'keypair\_name' or 'public\_key\_text' needs to be set. | `string` | `null` | no |
| <a name="input_multiaz"></a> [multiaz](#input\_multiaz) | Flag to specify that the FreeIPA and DataLake instances will be deployed across multi-availability zones. | `bool` | `true` | no |
| <a name="input_proxy_config_name"></a> [proxy\_config\_name](#input\_proxy\_config\_name) | Name of the proxy config to use for the environment. | `string` | `null` | no |
| <a name="input_public_key_text"></a> [public\_key\_text](#input\_public\_key\_text) | SSH Public key string for the nodes of the CDP environment. Required for CDP deployment on Azure. For CDP deployment on AWS, either 'keypair\_name' or 'public\_key\_text' needs to be set. | `string` | `null` | no |
| <a name="input_s3_guard_table_name"></a> [s3\_guard\_table\_name](#input\_s3\_guard\_table\_name) | Name for the DynamoDB table backing S3Guard. Only applicable for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_use_public_ips"></a> [use\_public\_ips](#input\_use\_public\_ips) | Use public ip's for the CDP resources created within the Cloud network. Required for CDP deployment on Azure and GCP. | `bool` | `null` | no |
| <a name="input_use_single_resource_group"></a> [use\_single\_resource\_group](#input\_use\_single\_resource\_group) | Use a single resource group for all provisioned CDP resources. Required for CDP deployment on Azure. | `bool` | `true` | no |
| <a name="input_workload_analytics"></a> [workload\_analytics](#input\_workload\_analytics) | Flag to specify if workload analytics should be enabled for the CDP environment | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cdp_environment_crn"></a> [cdp\_environment\_crn](#output\_cdp\_environment\_crn) | CDP Environment CRN |
| <a name="output_cdp_environment_name"></a> [cdp\_environment\_name](#output\_cdp\_environment\_name) | CDP Environment Name |
<!-- END_TF_DOCS -->