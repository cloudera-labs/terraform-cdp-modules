# Terraform Module for Azure NFS

This module contains resource files and example variable definition files for creating the Azure NFS file share required for Cloudera AI on cloud.

* Provisions a storage account with Premium Tier and Disabled Https traffic only.
* Creates a NFS file share of 100 GB in the storage account
* Creates a private dns zone of type privatelink.file.core.windows.net
* Creates a VNet link between the Cloudera workload VNet and private DNS zone.
* Creates a private endpoint for the NFS storage account (file sub-resource) for the specified subnets in the Cloudera VNet.
* Creates a public IP , security group allowing port 22 from everywhere
* Creates an Ubuntu virtual machine with a public IP and security group in the Cloudera subnets where the private endpoint was created.

## Usage

The [examples](./examples) directory has example Azure Cloud Service Provider deployments for different scenarios:

* `ex01-nfs_fileshare` uses a set of inputs for the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
