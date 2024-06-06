output "vpc_ids" {
  description = "Map of subnet ids with names"
  value = {for key, value in aws_vpc.vpcs : key => value.id}
}

output "subnet_ids" {
  description = "Map of subnet ids with names"
  value = { 
    private = aws_subnet.subnets["private"].id
    public = aws_subnet.subnets["public"].id
    vpn = aws_subnet.subnets["vpn"].id
  }
}