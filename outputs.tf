output "vpc" {
  value = module.vpc.id
}

output "subnet" {
    value = module.subnet.id
}

output "cidr" {
    value = module.subnet.cidr
}

output "security_group" {
    value = module.security_group.id
}

output "ssh_key" {
    value = module.ssh_key.id
}
