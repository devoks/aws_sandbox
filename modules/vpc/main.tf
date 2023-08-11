resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

resource "aws_subnet" "this" {
  for_each             = var.subnets
  vpc_id               = aws_vpc.this.id
  cidr_block           = each.value.cidr_block
  availability_zone_id = each.value.availability_zone_id
}

# resource "aws_internet_gateway" "this" {
#   vpc_id = aws_vpc.this.id
# }

# resource "aws_internet_gateway_attachment" "this" {
#   internet_gateway_id = aws_internet_gateway.this.id
#   vpc_id              = aws_vpc.this.id
# }

# resource "aws_route_table" "this" {
#   vpc_id = aws_vpc.this.id
# }

# resource "aws_route" "this" {
#   route_table_id         = aws_route_table.this.id
#   destination_cidr_block = "75.70.86.178/32"
#   gateway_id             = aws_internet_gateway.this.id
# }

# resource "aws_route_table_association" "this" {
#   for_each       = var.subnets
#   subnet_id      = aws_subnet.this[each.key]
#   route_table_id = aws_route_table.this.id
# }
