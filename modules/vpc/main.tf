
locals {
    name      = var.name
    cidr      = var.cidr
    select    = ( var.select ? 1 : 0 )
    provision = ( var.provision ? 1 : 0 )
}

data "aws_vpc" "selected" {
  count = local.select
  filter {
    name = "tag:Name"
    values = [local.name]
  }
}
resource "aws_vpc" "new" {
  count      = local.provision
  cidr_block = local.cidr
  assign_generated_ipv6_cidr_block = true
  tags = {
    Name = local.name
  }
}
# resource "aws_route_table" "new" {
#   count      = local.provision
#   vpc_id     = aws_vpc.new[0].id
#   route = []
#   tags = {
#     Name = local.name
#   }
# }
# resource "aws_route" "internal" {
#   count                  = local.provision
#   route_table_id         = aws_route_table.new[0].id
#   gateway_id             = "local"
#   destination_cidr_block = local.cidr
# }
resource "aws_internet_gateway" "new" {
  count  = local.provision
  vpc_id = aws_vpc.new[0].id
}
resource "aws_route" "public" {
  count                  = local.provision
  route_table_id         = aws_vpc.new[0].default_route_table_id
  gateway_id             = aws_internet_gateway.new[0].id
  destination_cidr_block = "0.0.0.0/0"
}
