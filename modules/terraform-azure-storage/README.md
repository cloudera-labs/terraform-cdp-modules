<!-- BEGIN_TF_DOCS -->
# Terraform Module for Azure Storage

This module contains resource files and example variable definition files for creation and management of the Azure Storage Accounts and containers required for Cloudera Data Platform (CDP) Public Cloud. The module creates ADLS Gen2 storage accounts (StorageV2, Standard tier, LRS replication, HNS enabled) for the three CDP storage roles (data, log, backup) with internal deduplication when multiple roles resolve to the same account name. Containers (data, logs, backups) are created inside the appropriate accounts with private access. Optional network rules are supported (default action deny, service bypass, allowed subnet IDs and IP ranges).

Support for using pre-existing storage accounts and containers is provided via the `create_data_storage`, `create_log_storage` and `create_backup_storage` input variables for accounts, and `create_data_container`, `create_log_container` and `create_backup_container` for containers. When set to `false`, the corresponding `existing_*` variable is used to perform a data source lookup of the existing resource. A user can reuse an existing account but create a new container inside it, or reuse both. Outputs remain consistent regardless of the create or reuse path.

## Usage

The [examples](./examples) directory has examples of using this module:

* `ex01-minimal_inputs` demonstrates how this module can be used to create Azure storage accounts with minimum required inputs.
* `ex02-reuse_existing` demonstrates how to use existing Azure storage accounts and containers with this module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 5.0.0, < 6.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 5.0.0, < 6.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.cdp_storage_locations](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_network_rules.cdp_storage_access_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules) | resource |
| [azurerm_storage_container.cdp_backup_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.cdp_data_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.cdp_log_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_account.existing_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_container.existing_backup_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_container) | data source |
| [azurerm_storage_container.existing_data_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_container) | data source |
| [azurerm_storage_container.existing_log_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_container) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Azure region for created storage accounts | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where storage accounts will be created or looked up | `string` | n/a | yes |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Kind of storage account (StorageV2, BlobStorage, etc.) | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Replication type for the storage account (LRS, GRS, RAGRS, ZRS) | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Performance tier of the storage account (Standard or Premium) | `string` | `"Standard"` | no |
| <a name="input_backup_storage_account"></a> [backup\_storage\_account](#input\_backup\_storage\_account) | Name of the storage account for backup storage. Required when create\_backup\_storage is true. Defaults to data\_storage\_account if null. | `string` | `null` | no |
| <a name="input_backup_storage_container"></a> [backup\_storage\_container](#input\_backup\_storage\_container) | Name of the container for backup storage | `string` | `"backups"` | no |
| <a name="input_create_backup_storage"></a> [create\_backup\_storage](#input\_create\_backup\_storage) | Create a new storage account for backup storage. When false, an existing account is looked up via existing\_backup\_storage\_account. | `bool` | `true` | no |
| <a name="input_create_data_storage"></a> [create\_data\_storage](#input\_create\_data\_storage) | Create a new storage account for data storage. When false, an existing account is looked up via existing\_data\_storage\_account. | `bool` | `true` | no |
| <a name="input_create_log_storage"></a> [create\_log\_storage](#input\_create\_log\_storage) | Create a new storage account for log storage. When false, an existing account is looked up via existing\_log\_storage\_account. | `bool` | `true` | no |
| <a name="input_create_network_rules"></a> [create\_network\_rules](#input\_create\_network\_rules) | Enable creation of network rules for created storage accounts | `bool` | `false` | no |
| <a name="input_data_storage_account"></a> [data\_storage\_account](#input\_data\_storage\_account) | Name of the storage account for data storage. Required when create\_data\_storage is true. | `string` | `null` | no |
| <a name="input_data_storage_container"></a> [data\_storage\_container](#input\_data\_storage\_container) | Name of the container for data storage | `string` | `"data"` | no |
| <a name="input_existing_backup_storage_account"></a> [existing\_backup\_storage\_account](#input\_existing\_backup\_storage\_account) | Name of an existing storage account for backup storage. Required when create\_backup\_storage is false. | `string` | `null` | no |
| <a name="input_existing_backup_storage_container"></a> [existing\_backup\_storage\_container](#input\_existing\_backup\_storage\_container) | Name of an existing container for backup storage. Required when create\_backup\_storage is false. | `string` | `null` | no |
| <a name="input_existing_data_storage_account"></a> [existing\_data\_storage\_account](#input\_existing\_data\_storage\_account) | Name of an existing storage account for data storage. Required when create\_data\_storage is false. | `string` | `null` | no |
| <a name="input_existing_data_storage_container"></a> [existing\_data\_storage\_container](#input\_existing\_data\_storage\_container) | Name of an existing container for data storage. Required when create\_data\_storage is false. | `string` | `null` | no |
| <a name="input_existing_log_storage_account"></a> [existing\_log\_storage\_account](#input\_existing\_log\_storage\_account) | Name of an existing storage account for log storage. Required when create\_log\_storage is false. | `string` | `null` | no |
| <a name="input_existing_log_storage_container"></a> [existing\_log\_storage\_container](#input\_existing\_log\_storage\_container) | Name of an existing container for log storage. Required when create\_log\_storage is false. | `string` | `null` | no |
| <a name="input_log_storage_account"></a> [log\_storage\_account](#input\_log\_storage\_account) | Name of the storage account for log storage. Required when create\_log\_storage is true. Defaults to data\_storage\_account if null. | `string` | `null` | no |
| <a name="input_log_storage_container"></a> [log\_storage\_container](#input\_log\_storage\_container) | Name of the container for log storage | `string` | `"logs"` | no |
| <a name="input_network_rules_bypass"></a> [network\_rules\_bypass](#input\_network\_rules\_bypass) | List of services to bypass network rules (e.g. AzureServices, Logging, Metrics) | `list(string)` | <pre>[<br/>  "AzureServices"<br/>]</pre> | no |
| <a name="input_network_rules_default_action"></a> [network\_rules\_default\_action](#input\_network\_rules\_default\_action) | Default action for network rules (Allow or Deny) | `string` | `"Deny"` | no |
| <a name="input_network_rules_ip_rules"></a> [network\_rules\_ip\_rules](#input\_network\_rules\_ip\_rules) | List of IP CIDR ranges to allow through network rules | `list(string)` | `[]` | no |
| <a name="input_network_rules_subnet_ids"></a> [network\_rules\_subnet\_ids](#input\_network\_rules\_subnet\_ids) | List of virtual network subnet IDs to allow through network rules | `list(string)` | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Enable public network access on created storage accounts | `bool` | `true` | no |
| <a name="input_storage_suffix"></a> [storage\_suffix](#input\_storage\_suffix) | Suffix to append to storage account names for uniqueness. Only applied to created accounts. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to created resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_backup_storage_account"></a> [azure\_backup\_storage\_account](#output\_azure\_backup\_storage\_account) | Azure backup storage account name |
| <a name="output_azure_backup_storage_account_id"></a> [azure\_backup\_storage\_account\_id](#output\_azure\_backup\_storage\_account\_id) | Azure backup storage account ID |
| <a name="output_azure_backup_storage_account_primary_dfs_endpoint"></a> [azure\_backup\_storage\_account\_primary\_dfs\_endpoint](#output\_azure\_backup\_storage\_account\_primary\_dfs\_endpoint) | Azure backup storage account primary DFS endpoint |
| <a name="output_azure_backup_storage_container"></a> [azure\_backup\_storage\_container](#output\_azure\_backup\_storage\_container) | Azure backup storage container name |
| <a name="output_azure_backup_storage_container_id"></a> [azure\_backup\_storage\_container\_id](#output\_azure\_backup\_storage\_container\_id) | Azure backup storage container ID |
| <a name="output_azure_backup_storage_location"></a> [azure\_backup\_storage\_location](#output\_azure\_backup\_storage\_location) | Azure backup storage location (abfs:// URI) |
| <a name="output_azure_data_storage_account"></a> [azure\_data\_storage\_account](#output\_azure\_data\_storage\_account) | Azure data storage account name |
| <a name="output_azure_data_storage_account_id"></a> [azure\_data\_storage\_account\_id](#output\_azure\_data\_storage\_account\_id) | Azure data storage account ID |
| <a name="output_azure_data_storage_account_primary_dfs_endpoint"></a> [azure\_data\_storage\_account\_primary\_dfs\_endpoint](#output\_azure\_data\_storage\_account\_primary\_dfs\_endpoint) | Azure data storage account primary DFS endpoint |
| <a name="output_azure_data_storage_container"></a> [azure\_data\_storage\_container](#output\_azure\_data\_storage\_container) | Azure data storage container name |
| <a name="output_azure_data_storage_container_id"></a> [azure\_data\_storage\_container\_id](#output\_azure\_data\_storage\_container\_id) | Azure data storage container ID |
| <a name="output_azure_data_storage_location"></a> [azure\_data\_storage\_location](#output\_azure\_data\_storage\_location) | Azure data storage location (abfs:// URI) |
| <a name="output_azure_log_storage_account"></a> [azure\_log\_storage\_account](#output\_azure\_log\_storage\_account) | Azure log storage account name |
| <a name="output_azure_log_storage_account_id"></a> [azure\_log\_storage\_account\_id](#output\_azure\_log\_storage\_account\_id) | Azure log storage account ID |
| <a name="output_azure_log_storage_account_primary_dfs_endpoint"></a> [azure\_log\_storage\_account\_primary\_dfs\_endpoint](#output\_azure\_log\_storage\_account\_primary\_dfs\_endpoint) | Azure log storage account primary DFS endpoint |
| <a name="output_azure_log_storage_container"></a> [azure\_log\_storage\_container](#output\_azure\_log\_storage\_container) | Azure log storage container name |
| <a name="output_azure_log_storage_container_id"></a> [azure\_log\_storage\_container\_id](#output\_azure\_log\_storage\_container\_id) | Azure log storage container ID |
| <a name="output_azure_log_storage_location"></a> [azure\_log\_storage\_location](#output\_azure\_log\_storage\_location) | Azure log storage location (abfs:// URI) |
| <a name="output_storage_account_ids"></a> [storage\_account\_ids](#output\_storage\_account\_ids) | Map of storage account names to their IDs (created and pre-existing) |
<!-- END_TF_DOCS -->