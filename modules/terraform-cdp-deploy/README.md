<!-- BEGIN_TF_DOCS -->
# Terraform Module for CDP Deployment

This module contains resource files and example variable definition files for deployment of Cloudera Data Platform (CDP) Public Cloud environment and Datalake creation on AWS or Azure.

## Usage

The [examples](./examples) directory has example CDP deployments:

* `ex01-aws-basic` creates a basic CDP deployment on AWS. This example makes use of the [terraform-cdp-aws-pre-reqs module](../terraform-cdp-aws-pre-reqs) to create the required cloud resources.

* `ex02-azure-basic` creates a basic CDP deployment on Azure. This example makes use of the [terraform-cdp-azure-pre-reqs module](../terraform-cdp-azure-pre-reqs) to create the required cloud resources.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 1.3.0 |
| <a name="requirement_cdp"></a> [cdp](#requirement\_cdp) | 0.1.3-pre |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cdp_on_aws"></a> [cdp\_on\_aws](#module\_cdp\_on\_aws) | ./modules/aws | n/a |
| <a name="module_cdp_on_azure"></a> [cdp\_on\_azure](#module\_cdp\_on\_azure) | ./modules/azure | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_storage_location"></a> [backup\_storage\_location](#input\_backup\_storage\_location) | Backup storage location. The location has to be in uri format for the cloud provider - i.e. s3a:// for AWS, abfs:// for Azure,  gs:// | `string` | n/a | yes |
| <a name="input_data_storage_location"></a> [data\_storage\_location](#input\_data\_storage\_location) | Data storage location. The location has to be in uri format for the cloud provider - i.e. s3a:// for AWS, abfs:// for Azure,  gs:// | `string` | n/a | yes |
| <a name="input_deployment_template"></a> [deployment\_template](#input\_deployment\_template) | Deployment Pattern to use for Cloud resources and CDP | `string` | n/a | yes |
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
| <a name="input_aws_security_group_default_id"></a> [aws\_security\_group\_default\_id](#input\_aws\_security\_group\_default\_id) | ID of the Default Security Group for CDP environment. Required for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_aws_security_group_knox_id"></a> [aws\_security\_group\_knox\_id](#input\_aws\_security\_group\_knox\_id) | ID of the Knox Security Group for CDP environment. Required for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_aws_vpc_id"></a> [aws\_vpc\_id](#input\_aws\_vpc\_id) | AWS Virtual Private Network ID. Required for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_aws_xaccount_role_arn"></a> [aws\_xaccount\_role\_arn](#input\_aws\_xaccount\_role\_arn) | Cross Account Role ARN. Required for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_azure_cdp_gateway_subnet_names"></a> [azure\_cdp\_gateway\_subnet\_names](#input\_azure\_cdp\_gateway\_subnet\_names) | List of Azure Subnet Names CDP Endpoint Access Gateway. Required for CDP deployment on Azure. | `list(any)` | `null` | no |
| <a name="input_azure_cdp_subnet_names"></a> [azure\_cdp\_subnet\_names](#input\_azure\_cdp\_subnet\_names) | List of Azure Subnet Names for CDP Resources. Required for CDP deployment on Azure. | `list(any)` | `null` | no |
| <a name="input_azure_datalakeadmin_identity_id"></a> [azure\_datalakeadmin\_identity\_id](#input\_azure\_datalakeadmin\_identity\_id) | Datalake Admin Managed Identity ID. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_idbroker_identity_id"></a> [azure\_idbroker\_identity\_id](#input\_azure\_idbroker\_identity\_id) | IDBroker Managed Identity ID. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_log_identity_id"></a> [azure\_log\_identity\_id](#input\_azure\_log\_identity\_id) | Log Data Access Managed Identity ID. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_ranger_audit_identity_id"></a> [azure\_ranger\_audit\_identity\_id](#input\_azure\_ranger\_audit\_identity\_id) | Ranger Audit Managed Identity ID. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_raz_identity_id"></a> [azure\_raz\_identity\_id](#input\_azure\_raz\_identity\_id) | RAZ Managed Identity ID. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_resource_group_name"></a> [azure\_resource\_group\_name](#input\_azure\_resource\_group\_name) | Azure Resource Group name. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_security_group_default_uri"></a> [azure\_security\_group\_default\_uri](#input\_azure\_security\_group\_default\_uri) | Azure Default Security Group URI. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_security_group_knox_uri"></a> [azure\_security\_group\_knox\_uri](#input\_azure\_security\_group\_knox\_uri) | Azure Knox Security Group URI. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Subscription ID where the Azure pre-reqs are created. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | Tenant ID where the Azure pre-reqs are created. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_vnet_name"></a> [azure\_vnet\_name](#input\_azure\_vnet\_name) | Azure Virtual Network ID. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_xaccount_app_pword"></a> [azure\_xaccount\_app\_pword](#input\_azure\_xaccount\_app\_pword) | Password for the Azure AD Cross Account Application. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_azure_xaccount_app_uuid"></a> [azure\_xaccount\_app\_uuid](#input\_azure\_xaccount\_app\_uuid) | UUID for the Azure AD Cross Account Application. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_cdp_admin_group_name"></a> [cdp\_admin\_group\_name](#input\_cdp\_admin\_group\_name) | Name of the CDP IAM Admin Group associated with the environment. Defaults to '<env\_prefix>-cdp-admin-group' if not specified. | `string` | `null` | no |
| <a name="input_cdp_user_group_name"></a> [cdp\_user\_group\_name](#input\_cdp\_user\_group\_name) | Name of the CDP IAM User Group associated with the environment. Defaults to '<env\_prefix>-cdp-user-group' if not specified. | `string` | `null` | no |
| <a name="input_cdp_xacccount_credential_name"></a> [cdp\_xacccount\_credential\_name](#input\_cdp\_xacccount\_credential\_name) | Name of the CDP Cross Account Credential. Defaults to '<env\_prefix>-xaccount-cred' if not specified. | `string` | `null` | no |
| <a name="input_datalake_name"></a> [datalake\_name](#input\_datalake\_name) | Name of the CDP datalake. Defaults to '<env\_prefix>-<aw\|az\|gc\|>-dl' if not specified. | `string` | `null` | no |
| <a name="input_datalake_scale"></a> [datalake\_scale](#input\_datalake\_scale) | The scale of the datalake. Valid values are LIGHT\_DUTY, MEDIUM\_DUTY\_HA. | `string` | `null` | no |
| <a name="input_datalake_version"></a> [datalake\_version](#input\_datalake\_version) | The Datalake Runtime version. Valid values are semantic versions, e.g. 7.2.16 | `string` | `"7.2.16"` | no |
| <a name="input_enable_ccm_tunnel"></a> [enable\_ccm\_tunnel](#input\_enable\_ccm\_tunnel) | Flag to enable Cluster Connectivity Manager tunnel. If false then access from Cloud to CDP Control Plane CIDRs is required from via SG ingress | `bool` | `true` | no |
| <a name="input_enable_raz"></a> [enable\_raz](#input\_enable\_raz) | Flag to enable Ranger Authorization Service (RAZ) | `bool` | `true` | no |
| <a name="input_endpoint_access_scheme"></a> [endpoint\_access\_scheme](#input\_endpoint\_access\_scheme) | The scheme for the workload endpoint gateway. PUBLIC creates an external endpoint that can be accessed over the Internet. PRIVATE which restricts the traffic to be internal to the VPC / Vnet. Relevant in Private Networks. | `string` | `null` | no |
| <a name="input_env_prefix"></a> [env\_prefix](#input\_env\_prefix) | Shorthand name for the environment. Used in CDP resource descriptions. This will be used to construct the value of where any of the CDP resource variables (e.g. environment\_name, cdp\_iam\_admin\_group\_name) are not defined. | `string` | `null` | no |
| <a name="input_env_tags"></a> [env\_tags](#input\_env\_tags) | Tags applied to provisioned resources | `map(any)` | `null` | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Name of the CDP environment. Defaults to '<env\_prefix>-cdp-env' if not specified. | `string` | `null` | no |
| <a name="input_freeipa_instances"></a> [freeipa\_instances](#input\_freeipa\_instances) | The number of FreeIPA instances to create in the environment | `number` | `3` | no |
| <a name="input_keypair_name"></a> [keypair\_name](#input\_keypair\_name) | SSH Keypair name in Cloud Service Provider. Required for CDP deployment on AWS. | `string` | `null` | no |
| <a name="input_multiaz"></a> [multiaz](#input\_multiaz) | Flag to specify that the FreeIPA and DataLake instances will be deployed across multi-availability zones. | `bool` | `true` | no |
| <a name="input_public_key_text"></a> [public\_key\_text](#input\_public\_key\_text) | SSH Public key string for the nodes of the CDP environment. Required for CDP deployment on Azure. | `string` | `null` | no |
| <a name="input_use_public_ips"></a> [use\_public\_ips](#input\_use\_public\_ips) | Use public ip's for the CDP resources created within the Azure network. Required for CDP deployment on Azure. | `bool` | `null` | no |
| <a name="input_use_single_resource_group"></a> [use\_single\_resource\_group](#input\_use\_single\_resource\_group) | Use a single resource group for all provisioned CDP resources. Required for CDP deployment on Azure. | `bool` | `true` | no |
| <a name="input_workload_analytics"></a> [workload\_analytics](#input\_workload\_analytics) | Flag to specify if workload analytics should be enabled for the CDP environment | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->