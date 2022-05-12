
variable "select" {
  type = bool
  description = "True if the module should select a subnet instead of creating one."
}
variable "provision" {
  type = bool
  description = "True if the module should create a new subnet instead of selecting one."
}
variable "name" {
  type = string
  description = "The name of the subnet to find or create."
}

# Optional, only used when creating a subnet
variable "vpc_id" {
  type = string
  description = "The AWS unique id for the VPC which this subnet will be created in."
  default = "" 
}
variable "cidr" {
  type = string
  description = "The cidr for the subnet to create."
  default = ""
}
variable "owner" {
  type = string
  description = "The owner to tag on the subnet when creating it."
  default = ""
}
