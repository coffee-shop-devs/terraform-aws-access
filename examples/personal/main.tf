# this test generates objects generally considered personal
# this will generate a security group for your personal ip
# this will generate a ec2 key pair from a provided public key which you have the private key for (making it personal)
module "TestPersonal" {
  source              = "../../"
  owner               = var.email
  ssh_key             = var.ssh_key
  ip                  = var.ip
  ssh_key_name        = var.email
  security_group_name = var.email
  vpc_name            = "default"
  subnet_name         = "default"
  vpc_override        = true
  subnet_override     = true
}
