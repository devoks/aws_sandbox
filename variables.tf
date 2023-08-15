variable "networks" {
  type = map(object({
    cidr_block           = string
    instance_tenancy     = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
    tags                 = map(any)
    subnets = map(object({
      cidr_block           = string
      availability_zone_id = string
      tags                 = map(any)
    }))
  }))
}
