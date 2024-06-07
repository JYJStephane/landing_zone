# ids of each vpc
output "vpc_ids" {
  description = "Map of subnet ids with names"
  value = {for key, value in aws_vpc.vpcs : key => value.id}
}
# ids of each subnet
output "subnet_ids" {
  description = "Map of subnet ids with names"
  value = {for key, value in aws_subnet.subnets : key => value.id}
}