output "id" {
  value = ( var.select ? data.aws_vpc.selected[0].id : aws_vpc.new[0].id )
}
