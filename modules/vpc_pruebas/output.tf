output "vpc_id" {
  value = aws_vpc.vpc_virginia.id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}