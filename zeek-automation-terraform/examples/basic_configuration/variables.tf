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
# BACKEND CONFIGURATION VARIABLES
# -------------------------------------------------------------- #

variable "credentials" {
  description = "Path to a service account credentials file with rights to run the Google Zeek Automation. If this file is absent Terraform will fall back to Application Default Credentials."
  type        = string
  default     = ""
}

variable "bucket" {
  description = "Name of the bucket to store .tfstate file remotely."
  type        = string
}

# -------------------------------------------------------------- #
# MODULE VARIABLES
# -------------------------------------------------------------- #

variable "subnets" {
  description = "The list of subnets being created"
  type = list(object({
    mirror_vpc_subnet_cidr      = list(string)
    collector_vpc_subnet_cidr   = string
    collector_vpc_subnet_region = string
  }))
}

variable "mirror_vpc_network" {
  description = "Resource link of the network to add a peering to."
  type        = string
}

variable "mirror_vpc_subnets" {
  description = "Mirror VPC Subnets list to be mirrored."
  type        = map(list(string))
  default     = {}
}

variable "mirror_vpc_tags" {
  description = "Mirror VPC Tags list to be mirrored."
  type        = map(list(string))
  default     = {}
}

variable "mirror_vpc_instances" {
  description = "Mirror VPC Instances list to be mirrored."
  type        = map(list(string))
  default     = {}
}

variable "ip_protocols" {
  description = "Protocols that apply as a filter on mirrored traffic. Possible values: [\"tcp\", \"udp\", \"icmp\"]"
  type        = list(string)
  default     = []
}

variable "direction" {
  description = "Direction of traffic to mirror. Default value: \"BOTH\" Possible values: [\"INGRESS\", \"EGRESS\", \"BOTH\"]"
  type        = string
  default     = "BOTH"
}

variable "cidr_ranges" {
  description = "IP CIDR ranges that apply as a filter on the source (ingress) or destination (egress) IP in the IP header. Only IPv4 is supported."
  type        = list(string)
  default     = []
}
