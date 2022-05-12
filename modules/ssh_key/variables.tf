variable "select" {
  type = bool
  description = "True if the module should select an ssh key instead of creating one."
}
variable "provision" {
  type = bool
  description = "True if the module should create a new ssh key instead of selecting one."
}
variable "name" {
  type = string
  description = "The name of the ssh key to find or create."
}

# only used during creation
variable "public_key" {
  type = string
  description = "The contents of the public key to create."
}
variable "owner" {
  type = string
  description = "The owner to tag the public key with after creation."
}
