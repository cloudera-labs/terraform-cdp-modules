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

# ------- Cross Account Policy -------
resource "aws_iam_policy" "cml_backup_policy" {
  name        = var.cml_backup_policy_name
  description = "CDP CML Workspace Backup policy"

  tags = merge(var.tags, { Name = var.cml_backup_policy_name })

  policy = local.cml_backup_policy_doc
}

resource "aws_iam_policy" "cml_restore_policy" {
  name        = var.cml_restore_policy_name
  description = "CDP CML Workspace Restore policy"

  tags = merge(var.tags, { Name = var.cml_restore_policy_name })

  policy = local.cml_restore_policy_doc
}

# Attach CML backup policy to the xaccount role 
resource "aws_iam_role_policy_attachment" "cdp_xaccount_role_cml_backup_attach" {
  role       = data.aws_iam_role.xaccount_role.name
  policy_arn = aws_iam_policy.cml_backup_policy.arn
}

# Attach CML restore policy to the xaccount role 
resource "aws_iam_role_policy_attachment" "cdp_xaccount_role_cml_restore_attach" {
  role       = data.aws_iam_role.xaccount_role.name
  policy_arn = aws_iam_policy.cml_restore_policy.arn
}