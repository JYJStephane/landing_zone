# Creation of the VPC in the specified region with randomly generated suffix
resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.cidr_map["virginia2"]
  tags = {
    "Name" = "VPC 2"
  }
}

# Creation of the public network in the specified VPC with randomly generated suffix, instances launched here will receive a public IP
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.cidr_map["public2"]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Public Subnet 2"
  }
}

# Creation of a public route table in a specific VPC. The route table includes a route that sends all traffic through an Internet Gateway (IGW).
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    "Name" = "Private Route Table 2"
  }
}

# We associate the routing table with the public subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Creates a security group for a specific VPC, allowing SSH access from any IP and permitting all outbound traffic. It dynamically sets up inbound rules based on a list of ports, and tags the security group with a name that includes a variable suffix.
resource "aws_security_group" "public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH, IMCP, HTTP, HTTPS inbound traffic and ALL egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  dynamic "ingress" {
    # Remove cases any and default from our list because they deny or allow all traffic and we need to specify
    for_each = {
      for key, value in var.ports : key => value
      if key != "any" && key != "default"
    }
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = [var.cidr_map["any"]]
    }
  }

  egress {
    from_port   = var.ports["default"].port
    to_port     = var.ports["default"].port
    protocol    = var.ports["default"].protocol
    cidr_blocks = [var.cidr_map["any"]]
  }

  tags = {
    "Name" = "Security Group 2"
  }
}

resource "aws_instance" "public_instance" {
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.public_instance.id]
  tags = {
    "Name" = "Instancia VPC 2"
  }
}
