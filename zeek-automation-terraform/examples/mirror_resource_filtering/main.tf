/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# -------------------------------------------------------------- #
# PROVIDER CONFIGURATION
# -------------------------------------------------------------- #

provider "google" {
  credentials = var.credentials
}

# -------------------------------------------------------------- #
# GET GCP METADATA
# -------------------------------------------------------------- #

data "google_client_openid_userinfo" "main" {}

# -------------------------------------------------------------- #
# MODULE CONFIGURATIONS
# -------------------------------------------------------------- #

locals {
  gcp_project_id = element(split("@", element(split(".", data.google_client_openid_userinfo.main.email), 0)), 1)
}

module "google_zeek_automation" {
  source                = "<link>/google_zeek_automation"
  gcp_project           = local.gcp_project_id
  service_account_email = data.google_client_openid_userinfo.main.email

  credentials          = var.credentials
  subnets              = var.subnets
  mirror_vpc_network   = var.mirror_vpc_network
  mirror_vpc_subnets   = var.mirror_vpc_subnets
  mirror_vpc_instances = var.mirror_vpc_instances
  mirror_vpc_tags      = var.mirror_vpc_tags
}