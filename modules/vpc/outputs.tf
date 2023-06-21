output "id" {
  value = (var.select ? data.aws_vpc.selected[0].id : aws_vpc.new[0].id)
}
output "vpc" {
  value = (var.select ? data.aws_vpc.selected[0] : aws_vpc.new[0])
}