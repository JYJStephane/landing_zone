resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id        = var.vpc1_id
  peer_vpc_id   = var.vpc2_id
  auto_accept   = true

  tags = {
    Name = "VPC_Peering"
  }
}

resource "aws_route" "route_a_to_b" {
  route_table_id            = var.vpc1_route_table
  destination_cidr_block    = var.vpc2_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

resource "aws_route" "route_b_to_a" {
  route_table_id            = var.vpc2_route_table
  destination_cidr_block    = var.vpc1_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}