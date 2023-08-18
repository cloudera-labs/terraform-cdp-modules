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

  env_tags = merge(var.agent_source_tag, (
    coalesce(var.env_tags,
      { env_prefix = var.env_prefix }
    ))
  )

  aws_ami = coalesce(var.aws_ami, data.aws_ami.proxy_default.id)

  # Security Groups
  security_group_proxy_name = coalesce(var.security_group_proxy_name, "${var.env_prefix}-proxy-sg")

  proxy_security_group_id = (var.create_proxy_sg ?
  aws_security_group.proxy_sg[0].id : var.proxy_security_group_id)

  route_tables_to_update = flatten([
    for route in var.route_tables_to_update :
    [
      for rt in route.route_tables :
      {
        route_table            = rt
        destination_cidr_block = route.destination_cidr_block
      }
    ]
  ])

  # Load Balancer
  network_load_balancer_name = coalesce(var.network_load_balancer_name, "${var.env_prefix}-proxy-nlb")
  target_group_proxy_name    = coalesce(var.target_group_proxy_name, "${var.env_prefix}-proxy-tg")

  # Launch Template & Auto-scaling groups
  launch_template_proxy_name   = coalesce(var.launch_template_proxy_name, "${var.env_prefix}-proxy-lt")
  autoscaling_group_proxy_name = coalesce(var.autoscaling_group_proxy_name, "${var.env_prefix}-proxy-asg")

  # Route table to eni association
  #
  lb_eni_details = [
    for eni in data.aws_network_interface.proxy_lb :
    {
      eni_id    = eni.id
      az        = eni.availability_zone
      subnet_id = eni.subnet_id
    }
  ]

  route_table_details = [
    for rt in data.aws_route_table.proxy_rt :
    {
      rt_id      = rt.id
      subnet_ids = rt.associations[*].subnet_id
    }
  ]

  route_table_to_lb_eni_assoc = {
    for k, v in data.aws_route_table.proxy_rt : "${v.id}" => {
      # TODO: eni of same subnet assoc if possible otherwise the first eni_id in lb_eni_details
      eni = local.lb_eni_details[0].eni_id
    }
  }

}