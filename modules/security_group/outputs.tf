output "id" {
  value = ( var.select ? data.aws_security_group.selected[0].id : aws_security_group.new[0].id )
}
