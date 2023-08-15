variable "cidr_block" {
  type = string
}
variable "instance_tenancy" {
  type = string
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "tags" {
  type = map(any)
}

variable "subnets" {
  type = map(object({
    cidr_block           = string
    availability_zone_id = string
    tags                 = map(any)
  }))
}
