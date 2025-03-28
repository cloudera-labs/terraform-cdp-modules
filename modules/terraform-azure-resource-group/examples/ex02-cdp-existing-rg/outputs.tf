# Copyright 2025 Cloudera, Inc. All Rights Reserved.
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

output "resource_group_name" {
  description = "Azure Resource Group Name"
  value       = module.ex02_existing_rmgp.resource_group_name
}

output "resource_group_id" {
  description = "Azure Resource Group ID"
  value       = module.ex02_existing_rmgp.resource_group_id
}

output "resource_group_location" {
  description = "Azure Resource Group Location"
  value       = module.ex02_existing_rmgp.resource_group_location
}