module "vpc" {
  source               = "./modules/vpc"
  for_each             = var.networks
  cidr_block           = each.value.cidr_block
  instance_tenancy     = each.value.instance_tenancy
  enable_dns_support   = each.value.enable_dns_support
  enable_dns_hostnames = each.value.enable_dns_hostnames
  subnets              = each.value.subnets
}

resource "aws_s3_bucket" "example" {
  bucket   = "my-random-random-random-bucket"
  provider = aws.secondaccount
}


# resource "aws_ec2_transit_gateway" "this" {
#   auto_accept_shared_attachments = "enable"
# }
