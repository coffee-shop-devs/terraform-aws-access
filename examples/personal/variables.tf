variable "email" {
  description = "The email address of the user, this helps cloud maintainers contact users when neccessary."
}

variable "ip" {
  description = "The ip of your home computer, used to allow ingress in security group."
}

variable "ssh_key" {
  description = "The contents of the public key to place on the server's authorized keys for ssh access."
}
