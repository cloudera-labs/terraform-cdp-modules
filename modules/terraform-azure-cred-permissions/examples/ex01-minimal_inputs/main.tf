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

terraform {
  required_version = ">= 1.5.7"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.46.0"
    }
  }
}

provider "azuread" {
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

}

# Access information about Azure Subscription
data "azurerm_subscription" "current" {}

# ------- Azure Entra App -------
module "ex01_xaccount_app" {
  source = "../.."

  xaccount_app_name     = "${var.env_prefix}-xaccount-app"
  azure_subscription_id = data.azurerm_subscription.current.subscription_id
}
