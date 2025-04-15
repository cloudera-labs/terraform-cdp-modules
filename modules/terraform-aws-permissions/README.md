<!-- BEGIN_TF_DOCS -->
# Terraform Module for CDP Environment Permissions on AWS

This module contains resource files and example variable definition files for creation the AWS IAM permissions required for Cloudera Data Platform (CDP) Public Cloud environment and datalake deployment.

## Usage

The [examples](./examples) directory has the following examples for AWS Cloud permission deployments:

* `ex01-minimal-inputs` uses the minimum set of inputs for the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>5.30 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~>5.30 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.cdp_datalake_admin_role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.cdp_idbroker_role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.cdp_log_role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.cdp_ranger_audit_role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.cdp_backup_bucket_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_data_bucket_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_datalake_admin_s3_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_datalake_backup_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_datalake_restore_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_idbroker_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_log_bucket_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_log_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cdp_ranger_audit_s3_data_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.cdp_datalake_admin_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cdp_idbroker_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cdp_log_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cdp_ranger_audit_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach5](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_idbroker_role_attach1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_idbroker_role_attach2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_log_role_attach1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_log_role_attach3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach5](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cdp_datalake_admin_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cdp_idbroker_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cdp_log_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cdp_ranger_audit_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_bucket_access_policy_doc"></a> [backup\_bucket\_access\_policy\_doc](#input\_backup\_bucket\_access\_policy\_doc) | Contents of Backup Bucket Access Data Access Policy | `string` | n/a | yes |
| <a name="input_backup_bucket_access_policy_name"></a> [backup\_bucket\_access\_policy\_name](#input\_backup\_bucket\_access\_policy\_name) | Backup Bucket Access Data Access Policy Name | `string` | n/a | yes |
| <a name="input_backup_storage_bucket"></a> [backup\_storage\_bucket](#input\_backup\_storage\_bucket) | Name of the Backup storage bucket | `string` | n/a | yes |
| <a name="input_data_bucket_access_policy_doc"></a> [data\_bucket\_access\_policy\_doc](#input\_data\_bucket\_access\_policy\_doc) | Data Bucket Access Data Access Policy | `string` | n/a | yes |
| <a name="input_data_bucket_access_policy_name"></a> [data\_bucket\_access\_policy\_name](#input\_data\_bucket\_access\_policy\_name) | Data Bucket Access Data Access Policy Name | `string` | n/a | yes |
| <a name="input_data_storage_bucket"></a> [data\_storage\_bucket](#input\_data\_storage\_bucket) | Name of the Data storage bucket | `string` | n/a | yes |
| <a name="input_datalake_admin_role_name"></a> [datalake\_admin\_role\_name](#input\_datalake\_admin\_role\_name) | Datalake Admin role Name | `string` | n/a | yes |
| <a name="input_datalake_admin_s3_policy_doc"></a> [datalake\_admin\_s3\_policy\_doc](#input\_datalake\_admin\_s3\_policy\_doc) | Contents of Datalake Admin S3 Data Access Policy | `string` | n/a | yes |
| <a name="input_datalake_admin_s3_policy_name"></a> [datalake\_admin\_s3\_policy\_name](#input\_datalake\_admin\_s3\_policy\_name) | Datalake Admin S3 Data Access Policy Name | `string` | n/a | yes |
| <a name="input_datalake_backup_policy_doc"></a> [datalake\_backup\_policy\_doc](#input\_datalake\_backup\_policy\_doc) | Contents of Datalake Backup Data Access Policy | `string` | n/a | yes |
| <a name="input_datalake_backup_policy_name"></a> [datalake\_backup\_policy\_name](#input\_datalake\_backup\_policy\_name) | Datalake backup Data Access Policy Name | `string` | n/a | yes |
| <a name="input_idbroker_policy_doc"></a> [idbroker\_policy\_doc](#input\_idbroker\_policy\_doc) | Contents of IDBroker Assumer Policy Document. | `string` | n/a | yes |
| <a name="input_idbroker_policy_name"></a> [idbroker\_policy\_name](#input\_idbroker\_policy\_name) | IDBroker Policy name | `string` | n/a | yes |
| <a name="input_idbroker_role_name"></a> [idbroker\_role\_name](#input\_idbroker\_role\_name) | IDBroker service role Name | `string` | n/a | yes |
| <a name="input_log_bucket_access_policy_doc"></a> [log\_bucket\_access\_policy\_doc](#input\_log\_bucket\_access\_policy\_doc) | Contents of Log Bucket Access Data Access Policy | `string` | n/a | yes |
| <a name="input_log_bucket_access_policy_name"></a> [log\_bucket\_access\_policy\_name](#input\_log\_bucket\_access\_policy\_name) | Log Bucket Access Data Access Policy Name | `string` | n/a | yes |
| <a name="input_log_data_access_policy_doc"></a> [log\_data\_access\_policy\_doc](#input\_log\_data\_access\_policy\_doc) | Contents of Log Data Access Policy | `string` | n/a | yes |
| <a name="input_log_data_access_policy_name"></a> [log\_data\_access\_policy\_name](#input\_log\_data\_access\_policy\_name) | Log Data Access Policy Name | `string` | n/a | yes |
| <a name="input_log_role_name"></a> [log\_role\_name](#input\_log\_role\_name) | Log service role Name | `string` | n/a | yes |
| <a name="input_log_storage_bucket"></a> [log\_storage\_bucket](#input\_log\_storage\_bucket) | Name of the Log storage bucket | `string` | n/a | yes |
| <a name="input_ranger_audit_role_name"></a> [ranger\_audit\_role\_name](#input\_ranger\_audit\_role\_name) | Ranger Audit role Name | `string` | n/a | yes |
| <a name="input_ranger_audit_s3_policy_doc"></a> [ranger\_audit\_s3\_policy\_doc](#input\_ranger\_audit\_s3\_policy\_doc) | Contents of Ranger S3 Audit Data Access Policy | `string` | n/a | yes |
| <a name="input_ranger_audit_s3_policy_name"></a> [ranger\_audit\_s3\_policy\_name](#input\_ranger\_audit\_s3\_policy\_name) | Ranger S3 Audit Data Access Policy Name | `string` | n/a | yes |
| <a name="input_arn_partition"></a> [arn\_partition](#input\_arn\_partition) | The string used to subsitute ARN\_PARTITION placeholder in policy documents. | `string` | `"aws"` | no |
| <a name="input_backup_location_base"></a> [backup\_location\_base](#input\_backup\_location\_base) | The bucket and path to the location used for FreeIPA and Datalake backups. Should be specified as <backup\_storage\_bucket>/<some\_path> | `string` | `null` | no |
| <a name="input_datalake_restore_policy_doc"></a> [datalake\_restore\_policy\_doc](#input\_datalake\_restore\_policy\_doc) | Contents of Datalake Restore Data Access Policy | `string` | `null` | no |
| <a name="input_datalake_restore_policy_name"></a> [datalake\_restore\_policy\_name](#input\_datalake\_restore\_policy\_name) | Datalake restore Data Access Policy Name | `string` | `null` | no |
| <a name="input_log_location_base"></a> [log\_location\_base](#input\_log\_location\_base) | The bucket and path to the location for log storage. Should be specified as <log\_storage\_bucket>/<some\_path> | `string` | `null` | no |
| <a name="input_process_policy_placeholders"></a> [process\_policy\_placeholders](#input\_process\_policy\_placeholders) | Flag to enable replacement of the standard placeholders in the AWS CDP Policy documents | `bool` | `true` | no |
| <a name="input_storage_location_base"></a> [storage\_location\_base](#input\_storage\_location\_base) | The bucket and path to the Data Lake storage directory. Should be specified as <data\_storage\_bucket>/<some\_path> | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provised resources | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_datalake_admin_role_arn"></a> [aws\_datalake\_admin\_role\_arn](#output\_aws\_datalake\_admin\_role\_arn) | Datalake Admin role ARN |
| <a name="output_aws_datalake_admin_role_name"></a> [aws\_datalake\_admin\_role\_name](#output\_aws\_datalake\_admin\_role\_name) | Datalake Admin role Name |
| <a name="output_aws_idbroker_instance_profile_arn"></a> [aws\_idbroker\_instance\_profile\_arn](#output\_aws\_idbroker\_instance\_profile\_arn) | IDBroker instance profile ARN |
| <a name="output_aws_idbroker_role_name"></a> [aws\_idbroker\_role\_name](#output\_aws\_idbroker\_role\_name) | IDBroker role Name |
| <a name="output_aws_log_instance_profile_arn"></a> [aws\_log\_instance\_profile\_arn](#output\_aws\_log\_instance\_profile\_arn) | Log instance profile ARN |
| <a name="output_aws_log_role_name"></a> [aws\_log\_role\_name](#output\_aws\_log\_role\_name) | Log role Name |
| <a name="output_aws_ranger_audit_role_arn"></a> [aws\_ranger\_audit\_role\_arn](#output\_aws\_ranger\_audit\_role\_arn) | Ranger Audit role ARN |
| <a name="output_aws_ranger_audit_role_name"></a> [aws\_ranger\_audit\_role\_name](#output\_aws\_ranger\_audit\_role\_name) | Ranger Audit role Name |
<!-- END_TF_DOCS -->