# this test generates objects generally needed for a new project which is on its own network
# this will generate a new subnet for your project with the given cidr (this must be an unused block from the vpc's cidr)
# this will generate a security group for your project's cidr
module "TestProject" {
  source                  = "../../"
  owner                   = var.email
  vpc_name                = "default"
  subnet_cidr             = var.cidr
  ip                      = var.ip
  subnet_name             = "test"
  security_group_name     = "test"
  ssh_key_name            = "default"
  vpc_override            = true
  ssh_key_override        = true
}
