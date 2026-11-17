<!-- BEGIN_TF_DOCS -->
# Terraform Module for AWS S3 Storage

This module contains resource files and example variable definition files for creation and management of the AWS S3 storage buckets required for Cloudera Data Platform (CDP) Public Cloud. The module creates S3 buckets for the three CDP storage roles (data, log, backup) with internal deduplication when multiple roles resolve to the same bucket name. Public access blocks, optional versioning and KMS encryption are supported.

Support for using pre-existing S3 buckets is provided via the `create_data_storage`, `create_log_storage` and `create_backup_storage` input variables. When set to `false`, the corresponding `existing_*_bucket` variable is used to perform a data source lookup of the existing bucket. Outputs remain consistent regardless of the create or reuse path.

## Usage

The [examples](./examples) directory has examples of using this module:

* `ex01-minimal_inputs` demonstrates how this module can be used to create S3 storage buckets with minimum required inputs.
* `ex02-reuse_existing` demonstrates how to use existing S3 buckets with this module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.30 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.30 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.cdp_storage_locations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.cdp_storage_locations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.cdp_storage_location_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.cdp_storage_location_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_object.cdp_backup_storage_object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.cdp_log_storage_object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_bucket.existing_storage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_storage_bucket"></a> [backup\_storage\_bucket](#input\_backup\_storage\_bucket) | Name of the S3 bucket for backup storage. Required when create\_backup\_storage is true. | `string` | `null` | no |
| <a name="input_backup_storage_object"></a> [backup\_storage\_object](#input\_backup\_storage\_object) | Path for the backup storage object/folder within the bucket | `string` | `"backups/"` | no |
| <a name="input_create_backup_storage"></a> [create\_backup\_storage](#input\_create\_backup\_storage) | Create a new S3 bucket for backup storage. When false, an existing bucket is looked up via existing\_backup\_storage\_bucket. | `bool` | `true` | no |
| <a name="input_create_data_storage"></a> [create\_data\_storage](#input\_create\_data\_storage) | Create a new S3 bucket for data storage. When false, an existing bucket is looked up via existing\_data\_storage\_bucket. | `bool` | `true` | no |
| <a name="input_create_log_storage"></a> [create\_log\_storage](#input\_create\_log\_storage) | Create a new S3 bucket for log storage. When false, an existing bucket is looked up via existing\_log\_storage\_bucket. | `bool` | `true` | no |
| <a name="input_data_storage_bucket"></a> [data\_storage\_bucket](#input\_data\_storage\_bucket) | Name of the S3 bucket for data storage. Required when create\_data\_storage is true. | `string` | `null` | no |
| <a name="input_data_storage_object"></a> [data\_storage\_object](#input\_data\_storage\_object) | Path for the data storage object/folder within the bucket | `string` | `"data/"` | no |
| <a name="input_enable_bucket_versioning"></a> [enable\_bucket\_versioning](#input\_enable\_bucket\_versioning) | Enable versioning on created buckets. Has no effect on reused buckets. | `bool` | `false` | no |
| <a name="input_enable_public_access_block"></a> [enable\_public\_access\_block](#input\_enable\_public\_access\_block) | Apply S3 public access block to created buckets. Has no effect on reused buckets. | `bool` | `true` | no |
| <a name="input_existing_backup_storage_bucket"></a> [existing\_backup\_storage\_bucket](#input\_existing\_backup\_storage\_bucket) | Name of an existing S3 bucket for backup storage. Required when create\_backup\_storage is false. | `string` | `null` | no |
| <a name="input_existing_data_storage_bucket"></a> [existing\_data\_storage\_bucket](#input\_existing\_data\_storage\_bucket) | Name of an existing S3 bucket for data storage. Required when create\_data\_storage is false. | `string` | `null` | no |
| <a name="input_existing_log_storage_bucket"></a> [existing\_log\_storage\_bucket](#input\_existing\_log\_storage\_bucket) | Name of an existing S3 bucket for log storage. Required when create\_log\_storage is false. | `string` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Allow created buckets to be destroyed even when they contain objects | `bool` | `true` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | ARN of an existing KMS key to use for bucket encryption on created buckets. Has no effect on reused buckets. If null, no KMS encryption is applied. | `string` | `null` | no |
| <a name="input_log_storage_bucket"></a> [log\_storage\_bucket](#input\_log\_storage\_bucket) | Name of the S3 bucket for log storage. Required when create\_log\_storage is true. | `string` | `null` | no |
| <a name="input_log_storage_object"></a> [log\_storage\_object](#input\_log\_storage\_object) | Path for the log storage object/folder within the bucket | `string` | `"logs/"` | no |
| <a name="input_storage_suffix"></a> [storage\_suffix](#input\_storage\_suffix) | Suffix to append to bucket names for uniqueness. Passed from parent module. Only applied to created buckets. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to created resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_backup_storage_bucket"></a> [aws\_backup\_storage\_bucket](#output\_aws\_backup\_storage\_bucket) | AWS backup storage bucket name |
| <a name="output_aws_backup_storage_bucket_arn"></a> [aws\_backup\_storage\_bucket\_arn](#output\_aws\_backup\_storage\_bucket\_arn) | AWS backup storage bucket ARN |
| <a name="output_aws_backup_storage_bucket_id"></a> [aws\_backup\_storage\_bucket\_id](#output\_aws\_backup\_storage\_bucket\_id) | AWS backup storage bucket ID |
| <a name="output_aws_backup_storage_location"></a> [aws\_backup\_storage\_location](#output\_aws\_backup\_storage\_location) | AWS backup storage location (s3a:// URI) |
| <a name="output_aws_backup_storage_object"></a> [aws\_backup\_storage\_object](#output\_aws\_backup\_storage\_object) | AWS backup storage object path |
| <a name="output_aws_data_storage_bucket"></a> [aws\_data\_storage\_bucket](#output\_aws\_data\_storage\_bucket) | AWS data storage bucket name |
| <a name="output_aws_data_storage_bucket_arn"></a> [aws\_data\_storage\_bucket\_arn](#output\_aws\_data\_storage\_bucket\_arn) | AWS data storage bucket ARN |
| <a name="output_aws_data_storage_bucket_id"></a> [aws\_data\_storage\_bucket\_id](#output\_aws\_data\_storage\_bucket\_id) | AWS data storage bucket ID |
| <a name="output_aws_data_storage_location"></a> [aws\_data\_storage\_location](#output\_aws\_data\_storage\_location) | AWS data storage location (s3a:// URI) |
| <a name="output_aws_data_storage_object"></a> [aws\_data\_storage\_object](#output\_aws\_data\_storage\_object) | AWS data storage object path |
| <a name="output_aws_log_storage_bucket"></a> [aws\_log\_storage\_bucket](#output\_aws\_log\_storage\_bucket) | AWS log storage bucket name |
| <a name="output_aws_log_storage_bucket_arn"></a> [aws\_log\_storage\_bucket\_arn](#output\_aws\_log\_storage\_bucket\_arn) | AWS log storage bucket ARN |
| <a name="output_aws_log_storage_bucket_id"></a> [aws\_log\_storage\_bucket\_id](#output\_aws\_log\_storage\_bucket\_id) | AWS log storage bucket ID |
| <a name="output_aws_log_storage_location"></a> [aws\_log\_storage\_location](#output\_aws\_log\_storage\_location) | AWS log storage location (s3a:// URI) |
| <a name="output_aws_log_storage_object"></a> [aws\_log\_storage\_object](#output\_aws\_log\_storage\_object) | AWS log storage object path |
<!-- END_TF_DOCS -->