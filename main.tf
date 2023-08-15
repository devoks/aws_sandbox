data "aws_caller_identity" "management" {
}

data "aws_caller_identity" "secondaccount" {
  provider = aws.secondaccount
}

data "aws_caller_identity" "thirdaccount" {
  provider = aws.thirdaccount
}

module "vpc" {
  source               = "./modules/vpc"
  for_each             = var.networks
  cidr_block           = each.value.cidr_block
  instance_tenancy     = each.value.instance_tenancy
  enable_dns_support   = each.value.enable_dns_support
  enable_dns_hostnames = each.value.enable_dns_hostnames
  subnets              = each.value.subnets
  tags                 = each.value.tags
}

resource "aws_s3_bucket" "example" {
  bucket   = "my-random-random-random-random-bucket"
  provider = aws.thirdaccount
}

# // Create Transit Gateway

resource "aws_ec2_transit_gateway" "this" {
  description                    = "NetworkVPCTGW"
  amazon_side_asn                = 64512
  auto_accept_shared_attachments = "enable"
  vpn_ecmp_support               = "enable"
  tags = {
    Name = "tgw-useast1-core1"
  }
  depends_on = [module.vpc]
}

# // Attach Transit Gateway to VPC

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = ["subnet-03738d512688c480b", "subnet-00ae0e46ac7451f3e"]
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = "vpc-031928300d98047ca"
  depends_on         = [aws_ec2_transit_gateway.this]
}

# // Create RAM resource share

resource "aws_ram_resource_share" "this" {
  //  provider = aws.first

  name = "tgw-useast1-core1-share"

  tags = {
    Name = "tgw-useast1-core1-share"
  }
  depends_on = [aws_ec2_transit_gateway.this]
}

resource "aws_ram_resource_association" "this" {

  resource_arn       = aws_ec2_transit_gateway.this.arn
  resource_share_arn = aws_ram_resource_share.this.id
}

resource "aws_ram_principal_association" "this" {

  principal          = data.aws_caller_identity.secondaccount.account_id
  resource_share_arn = aws_ram_resource_share.this.id
}







# // https://github.com/mikemowgli/terraform-aws-transit-gateway/blob/master/deploy.tf
