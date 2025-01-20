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

# ------- Elastic IP Allocation -------
resource "aws_eip" "bastion_eip" {
  count = var.create_eip ? 1 : 0

  domain = "vpc"
  tags   = merge(var.env_tags, { Name = var.eip_name })
}

resource "aws_instance" "bastion" {
  ami                         = local.bastion_aws_ami
  instance_type               = var.bastion_aws_instance_type
  subnet_id                   = var.bastion_subnet_id
  key_name                    = var.bastion_aws_keypair_name
  vpc_security_group_ids      = [local.bastion_security_group_id]
  associate_public_ip_address = var.enable_bastion_public_ip
  user_data                   = var.bastion_user_data
  user_data_replace_on_change = var.replace_on_user_data_change

  tags = merge(var.env_tags, { Name = var.bastion_host_name })

  availability_zone                    = var.bastion_az
  iam_instance_profile                 = var.bastion_inst_profile
  private_ip                           = var.bastion_private_ip
  disable_api_termination              = var.disable_api_termination
  instance_initiated_shutdown_behavior = var.bastion_shutdown_behaviour
  source_dest_check                    = var.bastion_src_dest_check
  monitoring                           = var.bastion_monitoring
  tenancy                              = var.bastion_tenancy
  placement_group                      = var.bastion_placement_grp
  cpu_options {
  core_count = try(var.bastion_cpu_options.core_count, null) 
  threads_per_core = try(var.bastion_cpu_options.threads_per_core, null) 
  }
}

resource "aws_eip_association" "bastion_eip_assoc" {
  count = var.create_eip ? 1 : 0

  instance_id   = aws_instance.bastion.id
  allocation_id = aws_eip.bastion_eip[0].id
}

# ------- Networking - Security Group and Security Group rules -------
# Security Group for bastion
resource "aws_security_group" "bastion_sg" {

  count = var.create_bastion_sg ? 1 : 0

  vpc_id      = var.vpc_id
  name        = var.bastion_security_group_name
  description = var.bastion_security_group_name
  tags        = merge(var.env_tags, { Name = var.bastion_security_group_name })
}

# Create ingress SG rule
resource "aws_security_group_rule" "bastion_ingress" {

  for_each = { for k, v in var.ingress_rules : k => v
    if var.create_bastion_sg
  }

  security_group_id = aws_security_group.bastion_sg[0].id
  type              = "ingress"
  description       = "Ingress rules for ${var.bastion_security_group_name} Bastion Security Group"

  cidr_blocks = each.value.cidrs
  from_port   = each.value.from_port
  to_port     = coalesce(each.value.to_port, each.value.from_port)
  protocol    = each.value.protocol

}

# Create egress SG rule
resource "aws_security_group_rule" "bastion_egress" {

  for_each = { for k, v in var.egress_rules : k => v
    if var.create_bastion_sg
  }

  security_group_id = aws_security_group.bastion_sg[0].id
  type              = "egress"
  description       = "Egress rules for ${var.bastion_security_group_name} Bastion Security Group"

  cidr_blocks = each.value.cidrs #tfsec:ignore:aws-ec2-no-public-egress-sgr #tfsec:ignore:aws-vpc-no-public-egress-sgr
  from_port   = each.value.from_port
  to_port     = coalesce(each.value.to_port, each.value.from_port)
  protocol    = each.value.protocol

}