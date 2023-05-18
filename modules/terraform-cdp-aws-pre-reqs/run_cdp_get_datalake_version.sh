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
# Bash script to extract the datalake runtime version.
#
# Uses the command
#    'cdp datalake list-runtimes'
# to determine the list of available datalake runtime versions. 
# These are then returned as a JSON object for use in the 
# TF pre-reqs module.
#############################

# Step 1 - Parse the inputs
eval "$(jq -r '@sh "cdp_profile=\(.cdp_profile) cdp_region=\(.cdp_region)"')"

# Step 2 - Run the cdpcli command
export CDP_OUTPUT=$(cdp datalake list-runtimes --profile ${cdp_profile} --cdp-region ${cdp_region} --output json)

# Step 3 - Parse required outputs into variables
versions=$(echo $CDP_OUTPUT | jq --raw-output '[.versions[].runtimeVersion]')
defaultVersion=$(echo $CDP_OUTPUT | jq --raw-output '.versions[] | select(.defaultRuntimeVersion==true).runtimeVersion')
latestVersion=$(echo $CDP_OUTPUT | jq --raw-output '.versions[0].runtimeVersion')

# Step 4 - Output in JSON format
jq -n --arg latestVersion $latestVersion \
      --arg defaultVersion $defaultVersion \
      '{"latestVersion":$latestVersion,
        "defaultVersion":$defaultVersion}'
