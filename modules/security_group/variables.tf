
variable "select" {
  type = bool
  description = "True if the module should select a security group instead of creating one."
}
variable "provision" {
  type = bool
  description = "True if the module should create a new security group instead of selecting one."
}
variable "name" {
  type = string
  description = "The name of the security group to find or create."
}

# only used when generating a security group
variable "owner" {
  type = string
  description = "The owner to tag the security group with if generate one."
}
variable "ip" {
  type = string
  description = "The public IP addess to allow ingress from external WAN to the servers in the security group."
}
variable "cidr" {
  type = string
  description = "The cidr of the internal subnet to allow servers access to in the security group."
}