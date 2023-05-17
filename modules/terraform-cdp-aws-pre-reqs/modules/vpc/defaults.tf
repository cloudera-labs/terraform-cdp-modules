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

  azs_to_exclude = ["us-east-1e"] # List of AWS AZs which are not supported by CDP

  # Create a list of supported zones in the region
  zones_in_region = tolist(setsubtract(data.aws_availability_zones.zones_in_region.names, local.azs_to_exclude))

  # ------- Determine subnet details from inputs -------
  subnets_required = {
    total   = (var.deployment_template == "public") ? length(local.zones_in_region) : 2 * length(local.zones_in_region)
    public  = length(local.zones_in_region)
    private = (var.deployment_template == "public") ? 0 : length(local.zones_in_region)
  }
}