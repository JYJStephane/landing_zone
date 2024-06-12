# Creation of the VPC in the specified region.
resource "aws_vpc" "vpcs" {
  for_each = var.vpcs
  cidr_block = each.value.cidr_block
  tags = {
    "Name" = each.key
    "Name" = each.key
  }
}

# Creation of the subnets in the specified vpc.
resource "aws_subnet" "subnets" {
  for_each = {for subnet in local.vpc_subnets: subnet.name => subnet}
  vpc_id     = aws_vpc.vpcs[each.value.vpc_name].id
  cidr_block = each.value.data.cidr_block
  map_public_ip_on_launch = each.value.data.public
  tags = {
    Name = each.key
  }
}



# Dynamic creation of an internet gateway assigned to a vpc
resource "aws_internet_gateway" "ig" {
  for_each = aws_vpc.vpcs
  vpc_id = each.value.id
  tags = {
    "Name" = "IG-${each.key}"
  }
}

# Creation of a public route table in a specific VPC. The route table includes a
# route that sends all traffic through an Internet Gateway (IGW).
resource "aws_route_table" "route_tables" {
  for_each = {for subnet in local.vpc_subnets: subnet.name => subnet}
  vpc_id = aws_vpc.vpcs[each.value.vpc_name].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig[each.value.vpc_name].id
  }
  tags = {
    "Name" = each.key
  }
}

# Associate the route tables to each subnet
resource "aws_route_table_association" "routes_assoc" {
  for_each = {for subnet in local.vpc_subnets: subnet.name => subnet}
  subnet_id      = aws_subnet.subnets[each.value.name].id
  route_table_id = aws_route_table.route_tables[each.key].id
}



