
locals {
  owner = var.owner

  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr # create when cidr is given, otherwise select with name

  subnet_name = var.subnet_name
  subnet_cidr = var.subnet_cidr # create when cidr is given, otherwise select with name

  security_group_name = var.security_group_name
  security_group_type = var.security_group_type # create when type is given, otherwise select with name
  security_group_ip   = var.security_group_ip

  ssh_key_name   = var.ssh_key_name
  public_ssh_key = var.public_ssh_key # create when public key is given, otherwise select with name
}

data "http" "get_my_ip" {
  count = (local.security_group_ip == "" ? 1 : 0)
  url   = "https://ipinfo.io/ip"
}

module "vpc" {
  source = "./modules/vpc"
  name   = local.vpc_name
  cidr   = local.vpc_cidr
}

module "subnet" {
  source = "./modules/subnet"
  name   = local.subnet_name
  cidr   = local.subnet_cidr
  vpc_id = module.vpc.id
  owner  = local.owner
}

module "security_group" {
  source = "./modules/security_group"
  name   = local.security_group_name
  ip     = (local.security_group_ip == "" ? data.http.get_my_ip[0].response_body : local.security_group_ip)
  cidr   = module.subnet.cidr
  owner  = local.owner
  type   = local.security_group_type
}

module "ssh_key" {
  source     = "./modules/ssh_key"
  name       = local.ssh_key_name
  public_key = local.public_ssh_key
  owner      = local.owner
}
