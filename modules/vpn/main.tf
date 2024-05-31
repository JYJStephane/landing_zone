resource "aws_customer_gateway" "custom_gateway" {
  bgp_asn    = 65000
  ip_address = "163.116.243.56"  # La IP pública de tu router o firewall
  type       = "ipsec.1"
}

resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = var.vpc_id
}

resource "aws_vpn_gateway_attachment" "vpc_attach" {
  vpc_id          = var.vpc_id
  vpn_gateway_id  = aws_vpn_gateway.vpn_gateway.id
}

resource "aws_vpn_connection" "vpn" {
  customer_gateway_id = aws_customer_gateway.custom_gateway.id
  vpn_gateway_id      = aws_vpn_gateway.vpn_gateway.id
  type                = "ipsec.1"

  static_routes_only = true

}

resource "aws_vpn_connection_route" "route" {
  vpn_connection_id = aws_vpn_connection.vpn.id
  destination_cidr_block = "0.0.0.0/0"  # El CIDR de tu VPC
}

resource "aws_route" "vpn_route" {
  route_table_id         = var.vpc_route_table
  destination_cidr_block = "0.0.0.0/0" # Replace with your on-premises CIDR
  gateway_id             = aws_vpn_gateway.vpn_gateway.id
}