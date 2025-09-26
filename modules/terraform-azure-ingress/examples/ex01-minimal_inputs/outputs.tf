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

output "azure_security_group_default_uri" {
  value = module.ex01_sg.azure_default_security_group_uri

  description = "Azure Default Security Group URI"
}

output "azure_knox_security_group_uri" {
  value = module.ex01_sg.azure_knox_security_group_uri

  description = "Azure Knox Security Group URI"
}
