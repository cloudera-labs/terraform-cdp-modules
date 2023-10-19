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

# Find Availability Zones is AWS region
data "aws_availability_zones" "zones_in_region" {
  state = "available"
}

# Find details of the AWS vpc
data "aws_vpc" "vpc" {
  id = local.vpc_id
}

data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }

  # Postcondition to verify subnets are part of VPC
  lifecycle {
    postcondition {
      condition     = (length(setsubtract(local.public_subnet_ids, self.ids)) == 0) && (length(setsubtract(local.private_subnet_ids, self.ids)) == 0)
      error_message = "One or more of the provided subnets - ${join(",", setsubtract(concat(local.public_subnet_ids, local.private_subnet_ids), self.ids))} - are not part of VPC ${local.vpc_id}"
    }
  }
}
