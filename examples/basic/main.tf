# this test generates all objects
module "TestBasic" {
  source              = "../../"
  owner               = var.email
  ssh_key             = var.ssh_key
  vpc_cidr            = "10.0.0.0/16"
  vpc_name            = "default"
  subnet_name         = "default"
  subnet_cidr         = "10.0.1.0/24"
  ssh_key_name        = "default"
  security_group_name = "default"
}
