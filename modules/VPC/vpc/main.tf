# Creation of the VPC in the specified region.
resource "aws_vpc" "vpcs" {
  for_each = {virginia = var.cidr_map["virginia"], vpn = var.cidr_map["vpn"]}
  cidr_block = each.value
  tags = {
    "Name" = each.key
  }
}

# Creating subnets dynamically based on cidr and assigning names 
resource "aws_subnet" "subnets" {
  for_each = {
    public  = var.cidr_map["public"]
    private = var.cidr_map["private"]
    vpn     = var.cidr_map["vpn_subnet"]
  }
  vpc_id                  = each.key == "vpn" ? aws_vpc.vpcs["vpn"].id : aws_vpc.vpcs["virginia"].id
  cidr_block              = each.value
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${each.key}Sub-Virginia"
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
  for_each = {
    public = aws_internet_gateway.ig["virginia"]
    private = aws_internet_gateway.ig["virginia"]
    vpn = aws_internet_gateway.ig["vpn"]
  }
  vpc_id = each.key == "vpn" ? aws_vpc.vpcs["vpn"].id : aws_vpc.vpcs["virginia"].id
  route {
    cidr_block = var.cidr_map["any"]
    gateway_id = each.value.id
  }
  tags = {
    "Name" = each.key
  }
}

# Associate the route tables to each subnet
resource "aws_route_table_association" "routes_assoc" {
  for_each = aws_route_table.route_tables
  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = each.value.id
}

