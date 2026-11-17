# Set up a Local Development Environment

As mentioned in the Usage section of the readme, the [cdp-tf-quickstarts](https://github.com/cloudera-labs/cdp-tf-quickstarts) repository demonstrates how to deploy Cloudera on cloud end-to-end in a simplified way, using the modules in this repository. If you would like to customize your setup, you may want to change some of the module code. To make sure you can test your changes locally and create customized deployments, we recommend the following setup:

1. Create a directory called `tf` and clone the Quickstart module repository

```bash
mkdir tf
cd tf
git clone https://github.com/cloudera-labs/cdp-tf-quickstarts.git
```

This will result in the directory structure below:

```bash
tree -L 4
.
└── tf
    └── cdp-tf-quickstarts
        ├── LICENSE
        ├── README.md
        ├── aws
        │   ├── main.tf
        │   ├── terraform.tfvars.template
        │   └── variables.tf
        └── azure
            ├── main.tf
            ├── terraform.tfvars.template
            └── variables.tf
``` 

The cdp-tf-quickstarts module consists of these few files only. This is achieved by loading the required submodules dynamically in the `main.tf` file:

```bash
module "cdp_aws_prereqs" {
  source = "git::https://github.com/cloudera-labs/terraform-cdp-modules.git//modules/terraform-cdp-aws-pre-reqs?ref=v0.1.0"
  …
}
```

2. For a local development environment these modules should be present locally. Make sure we are in the same project folder as earlier and clone this repository

```bash
cd ~/tf 
git clone https://github.com/cloudera-labs/terraform-cdp-modules.git
```

This will result in the following directory structure with the two cloned repositories:

```bash
cd ~
tree -L 4
.
└── tf
    ├── cdp-tf-quickstarts
    │   ├── LICENSE
    │   ├── README.md
    │   ├── aws
    │   │   ├── main.tf
    │   │   ├── terraform.tfvars.template
    │   │   └── variables.tf
    │   └── azure
    │       ├── main.tf
    │       ├── terraform.tfvars.template
    │       └── variables.tf
    └── terraform-cdp-modules
        ├── LICENSE
        ├── README.md
        └── modules
            ├── terraform-cdp-aws-pre-reqs
            ├── terraform-cdp-azure-pre-reqs
            └── terraform-cdp-deploy
```

3. The last step for setting up the local cdependencies is to link the two modules. To do this, simply edit the two main.tf files of the cdp-tf-quickstarts module.

## AWS

```bash
vi ~/tf/cdp-tf-quickstarts/aws/main.tf

# Change the first line of code in both "module" blocks:

# from 
source = "git::https://github.com/cloudera-labs/terraform-cdp-modules.git//modules/terraform-cdp-aws-pre-reqs?ref=v0.2.0"
# to 
source = "../../terraform-cdp-modules/modules/terraform-cdp-aws-pre-reqs"
# and from
source = "git::https://github.com/cloudera-labs/terraform-cdp-modules.git//modules/terraform-cdp-deploy?ref=v0.2.0"
# to
source = "../../terraform-cdp-modules/modules/terraform-cdp-deploy"
```

#### Azure
Same as above, just change the first module’s source to `source = "../../terraform-cdp-modules/modules/terraform-cdp-azure-pre-reqs"`

# Notes on Cloudera authentication

The Cloudera Terraform provider offers flexible authentication. The following methods are supported:

* Static credentials
* Environment variables
* Shared credentials file

See the [Cloudera Terraform provider documentation](https://registry.terraform.io/providers/cloudera/cdp/latest/docs#authentication) for more details on these authentication methods.

## Setting the Cloudera region

The [Cloudera Control Plane region](https://docs.cloudera.com/cdp-public-cloud/cloud/cp-regions/topics/cdp-control-plane-regions.html) associated with a set of Cloudera credentials can be specified in one of the following ways:

1. Set the control plane region name in the Cloudera provider configuration of the Terraform root module as shown below.

```terraform
provider "cdp" {
  # Example of setting control plane region to eu-1
  cdp_region = "eu-1"
}
```

2. Set the `CDP_REGION` environment variable in your terminal, e.g.:

```bash
export CDP_REGION="eu-1"
```

3. Set `cdp_region` in your Cloudera config file (`~/.cdp/config`). The following shows an example for the default profile and a custom profile.

```
[default]
cdp_region = us-west-1

[profile customprofile]
cdp_region = eu-1
```

See the Cloudera Terraform provider documentation for details on [setting the region](https://registry.terraform.io/providers/cloudera/cdp/latest/docs#setting-the-cdp-region).

## Setting the Cloudera profile

When using a shared credentials file, you can specify a custom profile (other than `default`) in one of the following ways:

1. Set the profile name in the Cloudera provider configuration of the Terraform root module as shown below.

```terraform
provider "cdp" {
  cdp_profile = "customprofile"
}
```

2. Set the `CDP_PROFILE` environment variable in your terminal, e.g.

```bash
export CDP_PROFILE="customprofile"
```
