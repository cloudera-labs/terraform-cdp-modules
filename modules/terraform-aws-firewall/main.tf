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

# ------- Firewall Rule Group -------
resource "aws_networkfirewall_rule_group" "cdp_env_fw_rg" {
  capacity = var.cdp_fw_rule_group_capacity
  name     = var.cdp_firewall_rule_group_name
  type     = "STATEFUL"

  rule_group {
    stateful_rule_options {
      rule_order = "STRICT_ORDER"
    }
    rule_variables {
      ip_sets {
        key = "HOME_NET"
        ip_set {
          definition = [data.aws_vpc.network_vpc.cidr_block, data.aws_vpc.cdp_vpc.cidr_block]
        }
      }
    }
    rules_source {
      rules_source_list {
        generated_rules_type = "ALLOWLIST"
        target_types         = ["TLS_SNI", "HTTP_HOST"]
        targets              = var.cdp_firewall_domain_allowlist
      }
    }

  }
  tags = var.tags
}
# ------- Firewall Policies -------
resource "aws_networkfirewall_firewall_policy" "fw_policy" {
  name = var.firewall_policy_name

  firewall_policy {
    stateful_default_actions = ["aws:drop_established", "aws:alert_established"]
    stateful_engine_options {
      rule_order              = "STRICT_ORDER"
      stream_exception_policy = "DROP"
    }
    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:forward_to_sfe"]

    # TODO: Handle multiple rule groups
    stateful_rule_group_reference {
      priority     = 1
      resource_arn = aws_networkfirewall_rule_group.cdp_env_fw_rg.arn
    }
  }

  tags = var.tags
}
# ------- Firewall -------
resource "aws_networkfirewall_firewall" "fw" {
  name                = var.firewall_name
  firewall_policy_arn = aws_networkfirewall_firewall_policy.fw_policy.arn
  vpc_id              = data.aws_vpc.network_vpc.id

  dynamic "subnet_mapping" {
    for_each = var.firewall_subnet_ids

    content {
      subnet_id = subnet_mapping.value
    }
  }

  tags = var.tags

  timeouts {
    create = "40m"
    update = "50m"
    delete = "1h"
  }
}

# ------- Route Table update -------

# Update the route tables to point to Firewall VPC Endpoint
resource "aws_route" "vpc_tgw_route" {
  for_each = {
    for k, v in local.route_tables_to_update : k => v
  }

  route_table_id         = each.value.route_table
  destination_cidr_block = each.value.destination_cidr_block

  # Where route AZ info is available, use Firewall VPC Endpoint from same AZ as subnet where route table is associated. Otherwise set to first Firewall Endpoint
  # Ref: https://github.com/hashicorp/terraform-provider-aws/issues/16759#issuecomment-1768591117
  vpc_endpoint_id = try(element([for ss in tolist(aws_networkfirewall_firewall.fw.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.availability_zone == each.value.availability_zone], 0), tolist(aws_networkfirewall_firewall.fw.firewall_status[0].sync_states)[0].attachment[0].endpoint_id)
}

# ------- Logging Configuration -------
resource "aws_cloudwatch_log_group" "nfw_log_group" {
  for_each = try(var.firewall_logging_config, {})

  name              = "/aws/network-firewall/${var.firewall_name}-${each.key}"
  retention_in_days = try(each.value.retention_in_days, null)
  log_group_class   = try(each.value.log_group_class, null)

  tags = var.tags

}

resource "aws_networkfirewall_logging_configuration" "nfw_log_config" {

  count = try(length(var.firewall_logging_config), 0) > 0 ? 1 : 0

  firewall_arn = aws_networkfirewall_firewall.fw.arn

  logging_configuration {
    dynamic "log_destination_config" {
      for_each = var.firewall_logging_config
      content {
        log_destination = {
          logGroup = aws_cloudwatch_log_group.nfw_log_group[log_destination_config.key].name
        }
        log_destination_type = "CloudWatchLogs"
        log_type             = upper(log_destination_config.key)
      }

    }
  }
}

