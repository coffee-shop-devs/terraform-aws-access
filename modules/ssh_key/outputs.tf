output "id" {
  value = (var.select ? data.aws_key_pair.selected[0].id : aws_key_pair.new[0].id)
}
output "ssh_key" {
  value = (var.select ? data.aws_key_pair.selected[0] : aws_key_pair.new[0])
}