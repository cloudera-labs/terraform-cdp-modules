# Terraform Module for Azure NFS

This module contains resource files and example variable definition files for creation of the Azure NFS File Share required for Cloudera Machine Learning (CML) Public Cloud.

* Provisions a storage account with Premium Tier and Disabled Https traffic only.
* Creates a NFS file share of 100 GB in the storage account
* Creates a private dns zone of type privatelink.file.core.windows.net
* Creates a VNET link between CDP workload VNET and private DNS zone
* Creates a private endpoint for NFS Storage Account (File sub-resource) for the specified subnets in the CDP VNET.
* Creates a public IP , security group allowing port 22 from everywhere
* Creates a ubuntu VM with public IP, security group in the CDP Subnets to which private endpoint was created.

## Usage

The [examples](./examples) directory has example Azure Cloud Service Provider deployments for different scenarios:

* `ex01-nfs_fileshare` uses a set of inputs for the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
