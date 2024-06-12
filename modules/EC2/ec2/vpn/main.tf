# Creation of the specific vpn out from the loop because of the needs to exist to launch the other instances user datas
resource "aws_instance" "vpn" {
  ami                    = var.vpcs["vpn"].subnets["vpn"].instances["vpn"].ami
  instance_type          = var.vpcs["vpn"].subnets["vpn"].instances["vpn"].type
  subnet_id              = var.subnet_ids["vpn"]
  key_name               = var.key_pair["vpn"]
  vpc_security_group_ids = [var.sg_ids["vpn"]]
  user_data              = local.vpn
  associate_public_ip_address = true
  tags = {
    "Name" = "${"vpn"}"
  }
}