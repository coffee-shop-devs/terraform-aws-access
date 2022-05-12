locals {
  select    = ( var.select ? 1 : 0)
  provision = ( var.provision ? 1 : 0 )
  name      = var.name
  owner     = var.owner
  ip        = var.ip
  cidr      = var.cidr
}

data "aws_security_group" "selected" {
  count = local.select
  filter {
    name = "tag:Name"
    values = [local.name]
  }
}
resource "aws_security_group" "new" {
  count       = local.provision
  description = "security group for single person ssh"
  tags = {
    Name  = local.name
    Owner = local.owner
  }
}
resource "aws_security_group_rule" "ssh_from_ip" {
  count             = local.provision
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["${local.ip}/32"]
  security_group_id = resource.aws_security_group.new[0].id
}
resource "aws_security_group_rule" "internal_ingress" {
  count             = local.provision
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [local.cidr]
  security_group_id = resource.aws_security_group.new[0].id
}
resource "aws_security_group_rule" "internal_egress" {
  count             = local.provision
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [local.cidr]
  security_group_id = resource.aws_security_group.new[0].id
}
resource "aws_security_group_rule" "external_egress" {
  count             = local.provision
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = resource.aws_security_group.new[0].id
}
