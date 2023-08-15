# // Create Transit Gateway

# resource "aws_ec2_transit_gateway" "this" {
#   description                    = "NetworkVPCTGW"
#   amazon_side_asn                = 64512
#   auto_accept_shared_attachments = "enable"
#   vpn_ecmp_support               = "enable"
#   tags = {
#     Name = "tgw-useast1-core1"
#   }
#   depends_on = [aws_vpc.main]
# }

# // Attach Transit Gateway to VPC

# resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
#   subnet_ids         = ["${aws_subnet.tgw-eni-az1.id}", "${aws_subnet.tgw-eni-az4.id}"]
#   transit_gateway_id = aws_ec2_transit_gateway.this.id
#   vpc_id             = aws_vpc.main.id
#   depends_on         = [aws_ec2_transit_gateway.this, aws_subnet.tgw-eni-az1, aws_subnet.tgw-eni-az4]
# }

# // Create RAM resource share

# resource "aws_ram_resource_share" "this" {
#   //  provider = aws.first

#   name = "tgw-useast1-core1-share"

#   tags = {
#     Name = "tgw-useast1-core1-share"
#   }
#   depends_on = [aws_ec2_transit_gateway.this]
# }

# resource "aws_ram_resource_association" "this" {
#   provider = aws.first

#   resource_arn       = aws_ec2_transit_gateway.example.arn
#   resource_share_arn = aws_ram_resource_share.example.id
# }









# // https://github.com/mikemowgli/terraform-aws-transit-gateway/blob/master/deploy.tf
