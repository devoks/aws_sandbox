// Create the VPC for the Network Account

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = var.tags
}

// Create 2 subnets for TGW attachments in AZ1, AZ4
// Create Private Subnets in Network VPC
// Create Public Subnets in Network VPC

resource "aws_subnet" "this" {
  for_each             = var.subnets
  vpc_id               = aws_vpc.this.id
  cidr_block           = each.value.cidr_block
  availability_zone_id = each.value.availability_zone_id
  tags                 = each.value.tags
}

// Create Internet Gateway for Network VPC
// Attach IGW to Network VPC

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "IGW-VPC1" # TODO string concatenate VPC ID here
  }
}

// Create custom route table for Private

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
}
