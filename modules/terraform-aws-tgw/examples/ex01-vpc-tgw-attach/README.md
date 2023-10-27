# Notes on this example

This example is split into two steps - the first step to create two VPCs (using the [terraform-aws-vpc](../../../terraform-aws-vpc/README.md) module); the second step to create the Transit Gateway and attach the VPCs from step 1 to the TGW.

The reason for the split in deployment steps is due to the dependencies between VPC and Transit Gateway configurations (mainly the number of VPC route tables are not known at plan time).

## Steps to execute the example

* Copy the example variables file, `terraform.tfvars.sample`, to `terraform.tfvars` and edit as needed. This same variable input file will be used across all deployment steps.

```bash
# Copy the sample input variable file
cp terraform.tfvars.sample terraform.tfvars

# Edit
vi terraform.tfvars
```

* Execute _Step 1_ to create the VPCs.

```bash
# change to the root module directory for step1
cd step1_vpcs

# Initialise the deployment
terraform init

# plan to review the infra changes
terraform plan -var-file ../terraform.tfvars 

# apply the infra changes
terraform apply -var-file ../terraform.tfvars
```

* Execute _Step 2_ to create the Transit Gateway and VPC attachments.

```bash
# change to the root module directory for step2 (command relative to the step1_vpcs directory)
cd ../step2_tgw

# Initialise the deployment
terraform init

# plan to review the infra changes
terraform plan -var-file ../terraform.tfvars 

# apply the infra changes
terraform apply -var-file ../terraform.tfvars
```
## Steps to clean up the example resources

To remove all resources created by this example, work in reverse order to the setup workflow.

* Change to the _Step 2_ directory and run Terraform destroy to delete the TGW and VPC Attachments

  ```bash
  # change to the root module directory for step2
  cd /step2_tgw

  # destroy terraform created resources
  terraform destroy -var-file ../terraform.tfvars
  ```

* Change to the _Step 1_ directory to remove the Networking and CDP VPCs.

    ```bash
    # change to the root module directory for step1
    cd ../step1_vpcs

    # destroy terraform created resources
    terraform destroy -var-file ../terraform.tfvars
    ```