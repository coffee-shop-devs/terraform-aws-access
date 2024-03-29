locals {
  name   = var.name
  select = (var.type == "" ? 1 : 0) # select if no type given
  create = (var.type != "" ? 1 : 0) # create if given a type
  type   = (local.types[(var.type == "" ? "none" : var.type)])
  owner  = var.owner
  ip     = var.ip
  cidr   = var.cidr
}

data "aws_security_group" "selected" {
  count = local.select
  filter {
    name   = "tag:Name"
    values = [local.name]
  }
}

resource "aws_security_group" "new" {
  count       = local.create
  description = "security group for single person"
  tags = {
    Name  = local.name
    Owner = local.owner
  }
}

# this rule allows ingress on any port from the ip specified
resource "aws_security_group_rule" "from_ip" {
  count             = (local.type.specific_ip_ingress ? 1 : 0)
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["${local.ip}/32"]
  security_group_id = aws_security_group.new[0].id
}
# this rule allows egress on any port to the ip specified
resource "aws_security_group_rule" "to_ip" {
  count             = (local.type.specific_ip_egress ? 1 : 0)
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["${local.ip}/32"]
  security_group_id = aws_security_group.new[0].id
}

# this rule allows any ip in the cidr on any port to initiate connections to the server
resource "aws_security_group_rule" "internal_ingress" {
  count             = (local.type.internal_ingress ? 1 : 0)
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [local.cidr]
  security_group_id = aws_security_group.new[0].id
}
# this rule allows the server to initiate connections to any ip in the cidr on any port
resource "aws_security_group_rule" "internal_egress" {
  count             = (local.type.internal_egress ? 1 : 0)
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [local.cidr]
  security_group_id = aws_security_group.new[0].id
}

# this is necessary if you want to update or install anything from the internet
# allows server to initiate connections to anywhere
resource "aws_security_group_rule" "external_egress" {
  count             = (local.type.public_egress ? 1 : 0)
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.new[0].id
}

# allows anywhere to initiate connections to server
# WARNING! this exposes your server to the public internet
resource "aws_security_group_rule" "external_ingress" {
  count             = (local.type.public_ingress ? 1 : 0)
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.new[0].id
}
