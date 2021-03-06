
variable "name" {
  type = string
  description = "The name of the VPC."
}
variable "cidr" {
  type = string
  description = "The cidr for the VPC."
}
variable "select" {
  type = bool
  description = "True if we should select a VPC instead of creating it."
}
variable "provision" {
  type = bool
  description = "True if we should create a VPC instead of selecting one."
}
