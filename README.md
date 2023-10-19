# Terraform Modules for CDP Prerequisites

This repository contains a number of Terraform modules for creation of the pre-requisite Cloud resources on AWS and Azure and the deployment of Cloudera Data Platform (CDP) Public Cloud.

## Modules

| Module name | Description |
| ----------- | ----------- |
| [terraform-cdp-aws-prereqs](modules/terraform-cdp-aws-pre-reqs/README.md) | For all AWS pre-requisite Cloud resources |
| [terraform-cdp-azure-prereqs](modules/terraform-cdp-azure-pre-reqs/README.md) | For all Azure pre-requisite Cloud resources |
| [terraform-cdp-deploy](modules/terraform-cdp-deploy/README.md) | For deployment of CDP on Azure or AWS see |
| [terraform-aws-vpc](modules/terraform-aws-vpc/README.md) | Standalone module for creation of the VPC on AWS. |

Each module contains Terraform resource configuration and example variable definition files.

## Usage

The [cdp-tf-quickstarts](https://github.com/cloudera-labs/cdp-tf-quickstarts) repository demonstrates how to use the modules together to deploy CDP on different cloud environments.

Each module also has a set of examples to show different configuration options for that module.

## Deployment

### Create infrastructure

Note that the instructions below give the steps to create pre-requisite resources and the CDP deployment all together. The modules can be used on their own to allow further customization.

1. Clone this repository using the following commands:

```bash
git clone https://github.com/cloudera-labs/terraform-cdp-modules.git
cd terraform-cdp-modules
```

2. To create cloud pre-requisite resources and the CDP deployment all together, change to the [terraform-cdp-deploy directory](./modules/terraform-cdp-deploy) and select one of the cloud providers.

```bash
cd modules/terraform-cdp-deploy/examples/ex<deployment_type>/
```

3. Create a `terraform.tfvars` file with variable definitions to run the module. Reference the `terraform.tfvars.sample` file in each example folder to create this file.

4. Run the Terraform module for the chosen deployment type:

```bash
terraform init
terraform apply
```

Once the deployment completes, you can create CDP Data Hubs and Data Services from the CDP Management Console (https://cdp.cloudera.com/).

## Clean up the infrastructure

If you no longer need the infrastructure that’s provisioned by the Terraform module, run the following command to remove the deployment infrastructure and terminate all resources.

```bash
terraform destroy
```

## Dependencies

To set up CDP via deployment automation using this guide, the following dependencies must be installed in your local environment:

* Terraform can be installed by following the instructions at https://developer.hashicorp.com/terraform/downloads

Configure Terraform Provider for AWS or Azure

* Configure the Terraform Provider for CDP with access key ID and private key by dowloading or creating a CDP configuation file.
  * See the [CDP documentation for steps to Generate the API access key](https://docs.cloudera.com/cdp-public-cloud/cloud/cli/topics/mc-cli-generating-an-api-access-key.html).

* To create resources in the Cloud Provider, access credentials or service account are needed for authentication.
  * For **AWS** access keys are required to be able to create the Cloud resources via the Terraform aws provider. See the [AWS Terraform Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration).
  * For **Azure**, authentication with the Azure subscription is required. There are a number of ways to do this outlined in the [Azure Terraform Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure).

## Local Development Environment

See the [DEVELOPMENT.md](./DEVELOPMENT.md) file for instructions on how to set up an environment for local development of modules.