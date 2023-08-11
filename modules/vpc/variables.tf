# variable "vpcs" {
#   type = map(object({
#     cidr_block           = string
#     instance_tenancy     = string
#     enable_dns_support   = bool
#     enable_dns_hostnames = bool
#   }))
# }

variable "cidr_block" {
  type = string
}

variable "instance_tenancy" {
  type = string
}

variable "enable_dns_support" {
  type = string
}

variable "enable_dns_hostnames" {
  type = string
}

variable "subnets" {
  type = map(object({
    cidr_block           = string
    availability_zone_id = string
    subnet_name          = string
  }))
}
