# Terraform Module for Azure Storage

This module contains resource files and example variable definition files for creating and managing the Azure Storage Accounts and containers required for Cloudera on Azure. The module creates Data Lake Storage Gen2 storage accounts (StorageV2, Standard tier, LRS replication, hierarchical namespace enabled) for the three storage roles (data, log, backup), with internal deduplication when multiple roles resolve to the same account name. Containers (data, logs, backups) are created inside the appropriate accounts with private access. Optional network rules are supported (default action deny, service bypass, allowed subnet IDs and IP ranges).

Support for using pre-existing storage accounts and containers is provided via the `create_data_storage`, `create_log_storage` and `create_backup_storage` input variables for accounts, and `create_data_container`, `create_log_container` and `create_backup_container` for containers. When set to `false`, the corresponding `existing_*` variable is used to perform a data source lookup of the existing resource. A user can reuse an existing account but create a new container inside it, or reuse both. Outputs remain consistent regardless of the create or reuse path.

## Usage

The [examples](./examples) directory has examples of using this module:

* `ex01-minimal_inputs` demonstrates how this module can be used to create Azure storage accounts with minimum required inputs.
* `ex02-reuse_existing` demonstrates how to use existing Azure storage accounts and containers with this module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
