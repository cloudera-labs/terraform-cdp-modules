# Copyright 2023 Cloudera, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

locals {

  azs_to_exclude_for_cdp = ["us-east-1e"] # List of AWS AZs which are not supported by CDP

  # Create a list of supported zones in the region
  zones_in_region = (var.cdp_vpc ?
    tolist(setsubtract(data.aws_availability_zones.zones_in_region.names, local.azs_to_exclude_for_cdp))
    :
    tolist(data.aws_availability_zones.zones_in_region.names)
  )


  # ------- Determine subnet details from inputs -------
  subnets_required = (var.cdp_vpc ?
    {
      total   = contains(["public", "private"], var.deployment_template) ? length(local.zones_in_region) : 2 * length(local.zones_in_region)
      public  = (var.deployment_template == "private") ? (var.private_network_extensions ? 1 : 0) : length(local.zones_in_region)
      private = (var.deployment_template == "public") ? 0 : length(local.zones_in_region)
    }
    :
    {
      total   = 2 * length(local.zones_in_region)
      public  = length(local.zones_in_region)
      private = length(local.zones_in_region)
  })

  # Extract the VPC CIDR range from the user-provided CIDR
  vpc_cidr_range = split("/", var.vpc_cidr)[1]

  # Calculate the first suitable CIDR range for public subnets after private subnets have been allocated (normalize the offset, expressed as a multiplier of public subnet ranges)
  public_subnet_offset = ceil(local.subnets_required.private * pow(2, 32 - var.private_cidr_range) / pow(2, 32 - var.public_cidr_range))

  # Extra tags for CDP public and private subnets
  private_subnet_tags = coalesce(
    var.private_subnet_tags,
    var.cdp_vpc ?
    { "kubernetes.io/role/internal-elb" = "1" }
    :
    {}
  )

  public_subnet_tags = coalesce(
    var.public_subnet_tags,
    var.cdp_vpc ?
    { "kubernetes.io/role/elb" = "1" }
    :
    {}
  )

  # For enable nat gateway:
  # use the input var if set, 
  # else for CDP vpc set value based on deployment template
  # else fallback to the terraform-aws-modules/vpc module default - false
  enable_nat_gateway = coalesce(var.enable_nat_gateway,
    (var.cdp_vpc ?
      (var.deployment_template == "private" ?
        (var.private_network_extensions ? true : false)
        : var.deployment_template == "semi-private" ?
        true
      : false)
    : false),
  false)

  # For single nat gateway:
  # use the input var if set, 
  # else for CDP vpc set value based on deployment template
  # else fallback to the terraform-aws-modules/vpc module default - false
  single_nat_gateway = coalesce(var.single_nat_gateway,
    (var.cdp_vpc ?
      (var.deployment_template == "private" ?
        (var.private_network_extensions ? true : false)
      : false)
    : false),
  false)

  # Determine the output Ids based on create_vpc flag and deployment_template
  vpc_id = (var.create_vpc ?
  module.vpc[0].vpc_id : var.existing_vpc_id)

  # If module creates the vpc:
  # * and it's a cdp vpc with private deployment template public subnets are always empty
  # * otherwise (i.e. not private deployment or cdp vpc ids from created vpc
  # If module doesn't create vpc:
  # * using existing ids
  public_subnet_ids = (var.create_vpc ?
    (var.cdp_vpc && (var.deployment_template == "private") ? [] : module.vpc[0].public_subnets)
  : var.existing_public_subnet_ids)

  private_subnet_ids = (var.create_vpc ?
    module.vpc[0].private_subnets : var.existing_private_subnet_ids
  )

  # Currently we only know the RT info if we create the VPC. Further work needed to lookup these resources when create_vpc is false.
  default_route_table_id  = (var.create_vpc ? module.vpc[0].default_route_table_id : null)
  public_route_table_ids  = (var.create_vpc ? module.vpc[0].public_route_table_ids : null)
  private_route_table_ids = (var.create_vpc ? module.vpc[0].private_route_table_ids : null)

}
