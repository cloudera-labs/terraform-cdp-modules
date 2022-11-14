#!/usr/bin/env bash

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

#################################################
# Bash script to extract the account id and
# external id of the CDP Public Cloud control plane.
#
# Accepts the Cloud Provider type as a dictionary input
# and uses the command
#    'cdp environments get-credential-prerequisites'
# to then determine the ids. These are then returned as a
# JSON object for use in the TF pre-reqs module.
#############################

# Step 1 - Parse the inputs and get upper and lower case version of infra_type
eval "$(jq -r '@sh "infra_type=\(.infra_type) cdp_profile=\(.cdp_profile) cdp_region=\(.cdp_region)"')"

# Lower case, suitable for bash <4
infra_type_lower=$(echo "$infra_type" | tr '[:upper:]' '[:lower:]')
# Upper case, suitable for bash <4
infra_type_upper=$(echo "$infra_type" | tr '[:lower:]' '[:upper:]')

# Step 2 - Run the cdpcli command
export CDP_OUTPUT=$(cdp environments get-credential-prerequisites --cloud-platform ${infra_type_upper} --profile ${cdp_profile} --cdp-region ${cdp_region} --output json)

# Step 3 - Parse required outputs into variables
accountId=$(echo $CDP_OUTPUT | jq --raw-output '.accountId')
externalId=$(echo $CDP_OUTPUT | jq --arg infra_type "$infra_type_lower" --raw-output '.[$infra_type].externalId')

# Step 4 - Output in JSON format
jq -n --arg accountId $accountId \
      --arg externalId $externalId \
      --arg infra_type "$infra_type_lower" \
      '{"infra_type":$infra_type, "account_id":$accountId, "external_id":$externalId}'

# Step 3-4 - All-in-one alternative
# echo $CDP_OUTPUT | jq --arg infra_type "$infra_type_lower" '{"infra_type":$infra_type, "accountId":.accountId, "externalId":.[$infra_type].externalId}'
    