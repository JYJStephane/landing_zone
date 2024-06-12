
# Creation of public instances given the length of the list, of the type of the specified AMI 
# with our own assigned key for SSH access. These belong to the public network and share the same 
# bootstrap script.
resource "aws_instance" "instances" {
  for_each = {for instance in local.vpc_instances: instance.instance_name => instance}
  ami                    = each.value.instance_ami
  instance_type          = each.value.instance_type
  subnet_id              = var.subnet_ids[each.value.subnet_name]
  key_name               = var.key_pair[each.value.subnet_name]
  vpc_security_group_ids = [var.sg_ids[each.key]]
  user_data              = local.scripts[each.value.instance_name]
  associate_public_ip_address = true
  tags = {
    "Name" = "${each.key}"
  }
}