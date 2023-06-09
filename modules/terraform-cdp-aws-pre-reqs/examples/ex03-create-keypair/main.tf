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

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

# Create and save a RSA key
resource "tls_private_key" "cdp_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save the private key to ./<env_prefix>-ssh-key.pem
resource "local_sensitive_file" "pem_file" {
  filename             = "${var.env_prefix}-ssh-key.pem"
  file_permission      = "600"
  directory_permission = "700"
  content              = tls_private_key.cdp_private_key.private_key_pem
}

# Create an AWS EC2 keypair from the generated public key
resource "aws_key_pair" "cdp_keypair" {
  key_name   = "${var.env_prefix}-keypair"
  public_key = tls_private_key.cdp_private_key.public_key_openssh
}

module "ex01_create_keypair" {
  source = "../.."

  env_prefix = var.env_prefix
  aws_region = var.aws_region

  aws_key_pair = aws_key_pair.cdp_keypair.key_name

  deployment_template = var.deployment_template

  ingress_extra_cidrs_and_ports = var.ingress_extra_cidrs_and_ports

}
