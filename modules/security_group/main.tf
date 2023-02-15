locals {
  select          = (var.select ? 1 : 0)
  provision       = (var.provision ? 1 : 0)
  external_egress = (var.external_egress ? 1 : 0)
  name            = var.name
  owner           = var.owner
  ip              = var.ip
  cidr            = var.cidr
}

data "aws_security_group" "selected" {
  count = local.select
  filter {
    name   = "tag:Name"
    values = [local.name]
  }
}

resource "aws_security_group" "new" {
  count       = local.provision
  description = "security group for single person"
  tags = {
    Name  = local.name
    Owner = local.owner
  }
}

# this rule allows ingress on any port from the ip specified
resource "aws_security_group_rule" "from_local" {
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

# this is necessary if you want to update or install anything
# only provisions if both are true
resource "aws_security_group_rule" "external_egress" {
  count             = local.provision * local.external_egress
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = resource.aws_security_group.new[0].id
}
