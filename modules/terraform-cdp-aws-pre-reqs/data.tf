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

# Find details about S3 Gateway endpoint services
data "aws_vpc_endpoint_service" "gateway_endpoints" {
  for_each = var.create_vpc && var.create_vpc_endpoints ? toset(var.vpc_endpoint_gateway_services) : []

  service      = each.key
  service_type = "Gateway"
}

# Find details about S3 Gateway endpoint services
data "aws_vpc_endpoint_service" "interface_endpoints" {
  for_each = var.create_vpc && var.create_vpc_endpoints ? toset(var.vpc_endpoint_interface_services) : []

  service      = each.key
  service_type = "Interface"
}
