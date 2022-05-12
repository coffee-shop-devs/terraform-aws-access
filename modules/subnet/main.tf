locals {
  select    = ( var.select ? 1 : 0 )
  provision = ( var.provision ? 1 : 0 )
  vpc_id    = var.vpc_id
  cidr      = var.cidr
  name      = var.name
  owner     = var.owner
}

data "aws_subnet" "selected" {
  count = local.select
  filter {
    name = "tag:Name"
    values = [local.name]
  }
}
resource "aws_subnet" "new" {
  count      = local.provision
  vpc_id     = local.vpc_id
  cidr_block = local.cidr
  tags = {
    Name  = local.name
    Owner = local.owner
  }
}
