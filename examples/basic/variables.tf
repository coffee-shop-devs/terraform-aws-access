variable "email" {
  description = "The email address of the user, this helps cloud maintainers contact users when neccessary."
}

variable "ssh_key" {
  description = "The contents of the public key to place on the server's authorized keys for ssh access."
}
