<!-- BEGIN_TF_DOCS -->
# Terraform Module for CDP Prerequisites on AWS

This module contains resource files and example variable definition files for creation of the pre-requisite AWS cloud resources required for Cloudera Data Platform (CDP) Public Cloud.

## Usage

The [examples](./examples) directory has example AWS Cloud Service Provider deployments for different scenarios:

* `ex01-minimal-inputs` uses the minimum set of inputs for the module.

* `ex02-existing-vpc` creates a VPC and subnets outside of the module and passes this as an additional input. CDP deployment then uses these network assets.

* `ex03-create-keypair` creates the AWS EC2 Keypair in the module caller and passes this as an additional input.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.67.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.2.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.2.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_cdp_vpc"></a> [aws\_cdp\_vpc](#module\_aws\_cdp\_vpc) | ../terraform-aws-vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.cdp_datalake_admin_role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.cdp_idbroker_role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.cdp_log_role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.cdp_ranger_audit_role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.cdp_bucket_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_datalake_admin_s3_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_datalake_backup_policy](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_datalake_restore_policy](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_idbroker_policy](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_log_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_ranger_audit_s3_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_xaccount_policy](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.cdp_datalake_admin_role](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role) | resource |
| [aws_iam_role.cdp_idbroker_role](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role) | resource |
| [aws_iam_role.cdp_log_role](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role) | resource |
| [aws_iam_role.cdp_ranger_audit_role](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role) | resource |
| [aws_iam_role.cdp_xaccount_role](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach1](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach2](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach3](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach4](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_idbroker_role_attach1](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_idbroker_role_attach2](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_log_role_attach1](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_log_role_attach2](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_log_role_attach3](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach1](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach2](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach3](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach4](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_xaccount_role_attach](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.cdp_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.cdp_kms_key](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/kms_key) | resource |
| [aws_s3_bucket.cdp_storage_locations](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.cdp_storage_locations](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.cdp_storage_location_kms](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_object.cdp_backup_storage_object](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/s3_object) | resource |
| [aws_s3_object.cdp_log_storage_object](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/s3_object) | resource |
| [aws_security_group.cdp_default_sg](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/security_group) | resource |
| [aws_security_group.cdp_endpoint_sg](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/security_group) | resource |
| [aws_security_group.cdp_knox_sg](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.cdp_default_sg_egress](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cdp_default_sg_ingress](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cdp_default_sg_ingress_self](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cdp_endpoint_ingress_self](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cdp_endpoint_sg_egress](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cdp_endpoint_sg_ingress](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cdp_knox_sg_egress](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cdp_knox_sg_ingress](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cdp_knox_sg_ingress_self](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/security_group_rule) | resource |
| [aws_vpc_endpoint.gateway_endpoints](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.interface_endpoints](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/vpc_endpoint) | resource |
| [random_id.bucket_suffix](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/id) | resource |
| [time_sleep.iam_propagation](https://registry.terraform.io/providers/hashicorp/time/0.9.1/docs/resources/sleep) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cdp_datalake_admin_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cdp_idbroker_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cdp_idbroker_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cdp_log_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cdp_ranger_audit_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cdp_xaccount_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/iam_policy_document) | data source |
| [aws_vpc_endpoint_service.gateway_endpoints](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/vpc_endpoint_service) | data source |
| [aws_vpc_endpoint_service.interface_endpoints](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/vpc_endpoint_service) | data source |
| [http_http.bucket_access_policy_doc](https://registry.terraform.io/providers/hashicorp/http/3.2.1/docs/data-sources/http) | data source |
| [http_http.datalake_admin_s3_policy_doc](https://registry.terraform.io/providers/hashicorp/http/3.2.1/docs/data-sources/http) | data source |
| [http_http.datalake_backup_policy_doc](https://registry.terraform.io/providers/hashicorp/http/3.2.1/docs/data-sources/http) | data source |
| [http_http.datalake_restore_policy_doc](https://registry.terraform.io/providers/hashicorp/http/3.2.1/docs/data-sources/http) | data source |
| [http_http.log_data_access_policy_doc](https://registry.terraform.io/providers/hashicorp/http/3.2.1/docs/data-sources/http) | data source |
| [http_http.ranger_audit_s3_policy_doc](https://registry.terraform.io/providers/hashicorp/http/3.2.1/docs/data-sources/http) | data source |
| [http_http.xaccount_account_policy_doc](https://registry.terraform.io/providers/hashicorp/http/3.2.1/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_template"></a> [deployment\_template](#input\_deployment\_template) | Deployment Pattern to use for Cloud resources and CDP | `string` | n/a | yes |
| <a name="input_env_prefix"></a> [env\_prefix](#input\_env\_prefix) | Shorthand name for the environment. Used in resource descriptions | `string` | n/a | yes |
| <a name="input_xaccount_account_id"></a> [xaccount\_account\_id](#input\_xaccount\_account\_id) | Account ID of the cross account | `string` | n/a | yes |
| <a name="input_xaccount_external_id"></a> [xaccount\_external\_id](#input\_xaccount\_external\_id) | External ID of the cross account | `string` | n/a | yes |
| <a name="input_agent_source_tag"></a> [agent\_source\_tag](#input\_agent\_source\_tag) | Tag to identify deployment source | `map(any)` | <pre>{<br>  "agent_source": "tf-cdp-module"<br>}</pre> | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region which Cloud resources will be created | `string` | `null` | no |
| <a name="input_backup_storage"></a> [backup\_storage](#input\_backup\_storage) | Optional Backup location for CDP environment. If not provided follow the data\_storage variable | <pre>object({<br>    backup_storage_bucket = string<br>    backup_storage_object = string<br>  })</pre> | `null` | no |
| <a name="input_bucket_access_policy_doc"></a> [bucket\_access\_policy\_doc](#input\_bucket\_access\_policy\_doc) | Bucket Access Data Access Policy | `string` | `null` | no |
| <a name="input_bucket_access_policy_name"></a> [bucket\_access\_policy\_name](#input\_bucket\_access\_policy\_name) | Bucket Access Data Access Policy Name | `string` | `null` | no |
| <a name="input_cdp_default_sg_egress_cidrs"></a> [cdp\_default\_sg\_egress\_cidrs](#input\_cdp\_default\_sg\_egress\_cidrs) | List of egress CIDR blocks for CDP Default Security Group Egress rule | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_cdp_endpoint_sg_egress_cidrs"></a> [cdp\_endpoint\_sg\_egress\_cidrs](#input\_cdp\_endpoint\_sg\_egress\_cidrs) | List of egress CIDR blocks for VPC Endpoint Security Group Egress rule | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_cdp_knox_sg_egress_cidrs"></a> [cdp\_knox\_sg\_egress\_cidrs](#input\_cdp\_knox\_sg\_egress\_cidrs) | List of egress CIDR blocks for CDP Knox Security Group Egress rule | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_cdp_private_subnet_ids"></a> [cdp\_private\_subnet\_ids](#input\_cdp\_private\_subnet\_ids) | List of private subnet ids. Required if create\_vpc is false. | `list(any)` | `null` | no |
| <a name="input_cdp_public_subnet_ids"></a> [cdp\_public\_subnet\_ids](#input\_cdp\_public\_subnet\_ids) | List of public subnet ids. Required if create\_vpc is false. | `list(any)` | `null` | no |
| <a name="input_cdp_vpc_id"></a> [cdp\_vpc\_id](#input\_cdp\_vpc\_id) | VPC ID for CDP environment. Required if create\_vpc is false. | `string` | `null` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Flag to specify if the VPC should be created | `bool` | `true` | no |
| <a name="input_create_vpc_endpoints"></a> [create\_vpc\_endpoints](#input\_create\_vpc\_endpoints) | Flag to specify if VPC Endpoints should be created | `bool` | `true` | no |
| <a name="input_data_storage"></a> [data\_storage](#input\_data\_storage) | Data storage locations for CDP environment | <pre>object({<br>    data_storage_bucket = string<br>    data_storage_object = string<br>  })</pre> | `null` | no |
| <a name="input_datalake_admin_role_name"></a> [datalake\_admin\_role\_name](#input\_datalake\_admin\_role\_name) | Datalake Admin role Name | `string` | `null` | no |
| <a name="input_datalake_admin_s3_policy_doc"></a> [datalake\_admin\_s3\_policy\_doc](#input\_datalake\_admin\_s3\_policy\_doc) | Location or Contents of Datalake Admin S3 Data Access Policy | `string` | `null` | no |
| <a name="input_datalake_admin_s3_policy_name"></a> [datalake\_admin\_s3\_policy\_name](#input\_datalake\_admin\_s3\_policy\_name) | Datalake Admin S3 Data Access Policy Name | `string` | `null` | no |
| <a name="input_datalake_backup_policy_doc"></a> [datalake\_backup\_policy\_doc](#input\_datalake\_backup\_policy\_doc) | Location of Datalake Backup Data Access Policy | `string` | `null` | no |
| <a name="input_datalake_backup_policy_name"></a> [datalake\_backup\_policy\_name](#input\_datalake\_backup\_policy\_name) | Datalake backup Data Access Policy Name | `string` | `null` | no |
| <a name="input_datalake_restore_policy_doc"></a> [datalake\_restore\_policy\_doc](#input\_datalake\_restore\_policy\_doc) | Location of Datalake Restore Data Access Policy | `string` | `null` | no |
| <a name="input_datalake_restore_policy_name"></a> [datalake\_restore\_policy\_name](#input\_datalake\_restore\_policy\_name) | Datalake restore Data Access Policy Name | `string` | `null` | no |
| <a name="input_enable_kms_bucket_encryption"></a> [enable\_kms\_bucket\_encryption](#input\_enable\_kms\_bucket\_encryption) | Flag to create AWS KMS for encryption of S3 buckets. Currently disabled as further settings needed for successful CDP deployment. | `bool` | `false` | no |
| <a name="input_env_tags"></a> [env\_tags](#input\_env\_tags) | Tags applied to provised resources | `map(any)` | `null` | no |
| <a name="input_idbroker_policy_name"></a> [idbroker\_policy\_name](#input\_idbroker\_policy\_name) | IDBroker Policy name | `string` | `null` | no |
| <a name="input_idbroker_role_name"></a> [idbroker\_role\_name](#input\_idbroker\_role\_name) | IDBroker service role Name | `string` | `null` | no |
| <a name="input_ingress_extra_cidrs_and_ports"></a> [ingress\_extra\_cidrs\_and\_ports](#input\_ingress\_extra\_cidrs\_and\_ports) | List of extra CIDR blocks and ports to include in Security Group Ingress rules | <pre>object({<br>    cidrs = list(string)<br>    ports = list(number)<br>  })</pre> | <pre>{<br>  "cidrs": [],<br>  "ports": []<br>}</pre> | no |
| <a name="input_log_data_access_policy_doc"></a> [log\_data\_access\_policy\_doc](#input\_log\_data\_access\_policy\_doc) | Location or Contents of Log Data Access Policy | `string` | `null` | no |
| <a name="input_log_data_access_policy_name"></a> [log\_data\_access\_policy\_name](#input\_log\_data\_access\_policy\_name) | Log Data Access Policy Name | `string` | `null` | no |
| <a name="input_log_role_name"></a> [log\_role\_name](#input\_log\_role\_name) | Log service role Name | `string` | `null` | no |
| <a name="input_log_storage"></a> [log\_storage](#input\_log\_storage) | Optional log locations for CDP environment. If not provided follow the data\_storage variable | <pre>object({<br>    log_storage_bucket = string<br>    log_storage_object = string<br>  })</pre> | `null` | no |
| <a name="input_private_cidr_range"></a> [private\_cidr\_range](#input\_private\_cidr\_range) | Size of each private subnet. Required if create\_vpc is true. Number of subnets will be automatically selected to match on the number of Availability Zones in the selected AWS region. (Depending on the selected deployment pattern, one subnet will be created per region.) | `number` | `19` | no |
| <a name="input_private_network_extensions"></a> [private\_network\_extensions](#input\_private\_network\_extensions) | Enable creation of resources for connectivity to CDP Control Plane (public subnet and NAT Gateway) for Private Deployment. Only relevant for private deployment template | `bool` | `true` | no |
| <a name="input_public_cidr_range"></a> [public\_cidr\_range](#input\_public\_cidr\_range) | Size of each public subnet. Required if create\_vpc is true. Number of subnets will be automatically selected to match on the number of Availability Zones in the selected AWS region. (Depending on the selected deployment pattern, one subnet will be created per region.) | `number` | `24` | no |
| <a name="input_random_id_for_bucket"></a> [random\_id\_for\_bucket](#input\_random\_id\_for\_bucket) | Create a random suffix for the bucket names | `bool` | `true` | no |
| <a name="input_ranger_audit_role_name"></a> [ranger\_audit\_role\_name](#input\_ranger\_audit\_role\_name) | Ranger Audit role Name | `string` | `null` | no |
| <a name="input_ranger_audit_s3_policy_doc"></a> [ranger\_audit\_s3\_policy\_doc](#input\_ranger\_audit\_s3\_policy\_doc) | Location or Contents of Ranger S3 Audit Data Access Policy | `string` | `null` | no |
| <a name="input_ranger_audit_s3_policy_name"></a> [ranger\_audit\_s3\_policy\_name](#input\_ranger\_audit\_s3\_policy\_name) | Ranger S3 Audit Data Access Policy Name | `string` | `null` | no |
| <a name="input_security_group_default_name"></a> [security\_group\_default\_name](#input\_security\_group\_default\_name) | Default Security Group for CDP environment | `string` | `null` | no |
| <a name="input_security_group_endpoint_name"></a> [security\_group\_endpoint\_name](#input\_security\_group\_endpoint\_name) | Security Group for VPC Endpoints | `string` | `null` | no |
| <a name="input_security_group_knox_name"></a> [security\_group\_knox\_name](#input\_security\_group\_knox\_name) | Knox Security Group for CDP environment | `string` | `null` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR Block. Required if create\_vpc is true. | `string` | `"10.10.0.0/16"` | no |
| <a name="input_vpc_endpoint_gateway_services"></a> [vpc\_endpoint\_gateway\_services](#input\_vpc\_endpoint\_gateway\_services) | List of AWS services used for VPC Gateway Endpoints | `list(string)` | <pre>[<br>  "s3"<br>]</pre> | no |
| <a name="input_vpc_endpoint_interface_services"></a> [vpc\_endpoint\_interface\_services](#input\_vpc\_endpoint\_interface\_services) | List of AWS services used for VPC Interface Endpoints | `list(string)` | <pre>[<br>  "sts",<br>  "rds",<br>  "elasticloadbalancing",<br>  "elasticfilesystem",<br>  "eks",<br>  "ecr.dkr",<br>  "ecr.api",<br>  "ec2",<br>  "cloudformation",<br>  "autoscaling"<br>]</pre> | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC. Defaults to <env\_prefix>-net if not specified | `string` | `null` | no |
| <a name="input_vpc_private_inbound_acl_rules"></a> [vpc\_private\_inbound\_acl\_rules](#input\_vpc\_private\_inbound\_acl\_rules) | Private subnets inbound network ACLs. Exposes default value of VPC module variable to allow for overriding. Only used when create\_vpc is true. | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_vpc_private_outbound_acl_rules"></a> [vpc\_private\_outbound\_acl\_rules](#input\_vpc\_private\_outbound\_acl\_rules) | Private subnets outbound network ACLs. Exposes default value of VPC module variable to allow for overriding. Only used when create\_vpc is true. | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_vpc_public_inbound_acl_rules"></a> [vpc\_public\_inbound\_acl\_rules](#input\_vpc\_public\_inbound\_acl\_rules) | Inbound network ACLs for Public subnets. Exposes default value of VPC module variable to allow for overriding. Only used when create\_vpc is true. | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_vpc_public_outbound_acl_rules"></a> [vpc\_public\_outbound\_acl\_rules](#input\_vpc\_public\_outbound\_acl\_rules) | Public subnets outbound network ACLs. Exposes default value of VPC module variable to allow for overriding. Only used when create\_vpc is true. | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_vpc_public_subnets_map_public_ip_on_launch"></a> [vpc\_public\_subnets\_map\_public\_ip\_on\_launch](#input\_vpc\_public\_subnets\_map\_public\_ip\_on\_launch) | Auto-assign public IP on launch for instances created in Public Subnets.  Exposes default value of VPC module variable to allow for overriding. Only used when create\_vpc is true. | `bool` | `true` | no |
| <a name="input_xaccount_account_policy_doc"></a> [xaccount\_account\_policy\_doc](#input\_xaccount\_account\_policy\_doc) | Location of cross acount policy document | `string` | `null` | no |
| <a name="input_xaccount_policy_name"></a> [xaccount\_policy\_name](#input\_xaccount\_policy\_name) | Cross Account Policy name | `string` | `null` | no |
| <a name="input_xaccount_role_name"></a> [xaccount\_role\_name](#input\_xaccount\_role\_name) | Cross account Assume role Name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_backup_storage_bucket"></a> [aws\_backup\_storage\_bucket](#output\_aws\_backup\_storage\_bucket) | AWS backup storage bucket |
| <a name="output_aws_backup_storage_location"></a> [aws\_backup\_storage\_location](#output\_aws\_backup\_storage\_location) | AWS backup storage location |
| <a name="output_aws_backup_storage_object"></a> [aws\_backup\_storage\_object](#output\_aws\_backup\_storage\_object) | AWS backup storage object |
| <a name="output_aws_data_storage_bucket"></a> [aws\_data\_storage\_bucket](#output\_aws\_data\_storage\_bucket) | AWS data storage bucket |
| <a name="output_aws_data_storage_location"></a> [aws\_data\_storage\_location](#output\_aws\_data\_storage\_location) | AWS data storage location |
| <a name="output_aws_data_storage_object"></a> [aws\_data\_storage\_object](#output\_aws\_data\_storage\_object) | AWS data storage object |
| <a name="output_aws_datalake_admin_role_arn"></a> [aws\_datalake\_admin\_role\_arn](#output\_aws\_datalake\_admin\_role\_arn) | Datalake Admin role ARN |
| <a name="output_aws_default_route_table_id"></a> [aws\_default\_route\_table\_id](#output\_aws\_default\_route\_table\_id) | AWS default route table ID |
| <a name="output_aws_idbroker_instance_profile_arn"></a> [aws\_idbroker\_instance\_profile\_arn](#output\_aws\_idbroker\_instance\_profile\_arn) | IDBroker instance profile ARN |
| <a name="output_aws_log_instance_profile_arn"></a> [aws\_log\_instance\_profile\_arn](#output\_aws\_log\_instance\_profile\_arn) | Log instance profile ARN |
| <a name="output_aws_log_role_name"></a> [aws\_log\_role\_name](#output\_aws\_log\_role\_name) | Log role Name |
| <a name="output_aws_log_storage_bucket"></a> [aws\_log\_storage\_bucket](#output\_aws\_log\_storage\_bucket) | AWS log storage bucket |
| <a name="output_aws_log_storage_location"></a> [aws\_log\_storage\_location](#output\_aws\_log\_storage\_location) | AWS log storage location |
| <a name="output_aws_log_storage_object"></a> [aws\_log\_storage\_object](#output\_aws\_log\_storage\_object) | AWS log storage object |
| <a name="output_aws_private_route_table_ids"></a> [aws\_private\_route\_table\_ids](#output\_aws\_private\_route\_table\_ids) | AWS private route table IDs |
| <a name="output_aws_private_subnet_ids"></a> [aws\_private\_subnet\_ids](#output\_aws\_private\_subnet\_ids) | AWS private subnet IDs |
| <a name="output_aws_public_route_table_ids"></a> [aws\_public\_route\_table\_ids](#output\_aws\_public\_route\_table\_ids) | AWS public route table IDs |
| <a name="output_aws_public_subnet_ids"></a> [aws\_public\_subnet\_ids](#output\_aws\_public\_subnet\_ids) | AWS public subnet IDs |
| <a name="output_aws_ranger_audit_role_arn"></a> [aws\_ranger\_audit\_role\_arn](#output\_aws\_ranger\_audit\_role\_arn) | Ranger Audit role ARN |
| <a name="output_aws_region"></a> [aws\_region](#output\_aws\_region) | Cloud provider region of the Environment |
| <a name="output_aws_security_group_default_id"></a> [aws\_security\_group\_default\_id](#output\_aws\_security\_group\_default\_id) | AWS security group id for default CDP SG |
| <a name="output_aws_security_group_knox_id"></a> [aws\_security\_group\_knox\_id](#output\_aws\_security\_group\_knox\_id) | AWS security group id for Knox CDP SG |
| <a name="output_aws_vpc_id"></a> [aws\_vpc\_id](#output\_aws\_vpc\_id) | AWS VPC ID |
| <a name="output_aws_vpc_subnets"></a> [aws\_vpc\_subnets](#output\_aws\_vpc\_subnets) | List of subnets associated with the CDP VPC |
| <a name="output_aws_xaccount_role_arn"></a> [aws\_xaccount\_role\_arn](#output\_aws\_xaccount\_role\_arn) | Cross Account role ARN |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags associated with the environment and its resources |
<!-- END_TF_DOCS -->