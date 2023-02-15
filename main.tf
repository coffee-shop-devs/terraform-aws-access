
locals {
  owner = var.owner

  vpc_name     = var.vpc_name
  vpc_cidr     = var.vpc_cidr
  vpc_override = var.vpc_override

  subnet_name     = var.subnet_name
  subnet_cidr     = var.subnet_cidr
  subnet_override = var.subnet_override

  security_group_name     = var.security_group_name
  security_group_override = var.security_group_override

  ssh_key_name     = var.ssh_key_name
  ssh_key          = var.ssh_key
  ssh_key_override = var.ssh_key_override
}

data "http" "get_my_ip" {
  url = "https://ipinfo.io/ip"
}

module "vpc" {
  source    = "./modules/vpc"
  name      = local.vpc_name
  cidr      = local.vpc_cidr
  select    = (local.vpc_override ? true : false)
  provision = (local.vpc_override ? false : true)
}

module "subnet" {
  source    = "./modules/subnet"
  name      = local.subnet_name
  cidr      = local.subnet_cidr
  vpc_id    = module.vpc.id
  owner     = local.owner
  select    = (local.subnet_override ? true : false)
  provision = (local.subnet_override ? false : true)
}

module "security_group" {
  source    = "./modules/security_group"
  name      = local.security_group_name
  ip        = data.http.get_my_ip.response_body
  cidr      = module.subnet.cidr
  owner     = local.owner
  select    = (local.security_group_override ? true : false)
  provision = (local.security_group_override ? false : true)
}

module "ssh_key" {
  source     = "./modules/ssh_key"
  name       = local.ssh_key_name
  public_key = local.ssh_key
  owner      = local.owner
  select     = (local.ssh_key_override ? true : false)
  provision  = (local.ssh_key_override ? false : true)
}
