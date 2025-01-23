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

################################################################################
# Firewall
################################################################################

output "nfw_id" {
  description = "The Amazon Resource id of the AWS Network Firewall"
  value       = aws_networkfirewall_firewall.fw.id
}

output "nfw_arn" {
  description = "The Amazon Resource Name (ARN) of the AWS Network Firewall"
  value       = aws_networkfirewall_firewall.fw.arn
}

################################################################################
# Firewall Logging Configuration
################################################################################

output "nfw_logging_configuration_ids" {
  description = "The Amazon Resource id (ARN) of the logging configuration associated with the AWS Network Firewall"
  value       = try(values(aws_networkfirewall_logging_configuration.nfw_log_config[*].id), null)
}

################################################################################
# Firewall Policy
################################################################################

output "nfw_policy_id" {
  description = "The Amazon Resource id of the firewall policy for the AWS Network Firewall"
  value       = aws_networkfirewall_firewall_policy.fw_policy.id
}

output "nfw_policy_arn" {
  description = "The Amazon Resource Name (ARN) that identifies the firewall policy"
  value       = aws_networkfirewall_firewall_policy.fw_policy.arn
}
