# Creates a security group dinamically for a specific VPC, allowing ports access 
# from any specified IP range and permitting all outbound traffic. It depends of 
# the ports variable from terraform.tfvars
resource "aws_security_group" "sg" {
  for_each = {for ports in local.sg_ports: ports.instance_name => ports}
  name     = each.value.instance_name
  vpc_id   = each.value.vpc_name == "vpn" ? var.vpc_ids[each.value.vpc_name] : var.vpc_ids[each.value.vpc_name]

  dynamic "ingress" {
    # Remove cases any and default from our list because they deny or allow all traffic and we need to specify
    for_each = each.value.ports
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "SG-${each.key}"
  }
}