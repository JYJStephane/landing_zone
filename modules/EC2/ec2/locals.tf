# The Linux commands that are executed in each instance are created once it is created
locals {
  scripts = {
    apache     = <<-EOF
  #!/bin/bash
  sudo su -

  # Installation of apache2 web server, then it enables and starts the service
  apt update -y
  apt install apache2 -y
  systemctl enable apache2
  systemctl start apache2

  # Installation of the firewall and application of the rules
  apt install firewalld -y
  firewall-cmd --zone=public --change-interface=eth0 --permanent
  firewall-cmd --zone=public --add-service=ssh --permanent
  firewall-cmd --zone=public --add-service=http --permanent
  firewall-cmd --zone=public --add-service=https --permanent
  firewall-cmd --reload
  EOF
    mysql      = <<-EOF
  #!/bin/bash
  sudo su -
  
  # Installation of mysql server, then it enables and starts the service
  apt update -y
  apt install mysql-server
  systemctl start mysql
  systemctl enable mysql
  
  # Installation of the firewall and application of the rules
  apt install firewalld -y
  firewall-cmd --zone=public --change-interface=eth0 --permanent
  firewall-cmd --zone=public --add-port=3306/tcp --permanent
  firewall-cmd --zone=public --add-service=ssh --permanent
  firewall-cmd --reload
  EOF
    monitoring = <<-EOF
  #!/bin/bash
  sudo su -

  # Creation of the keys directory
  mkdir /.ssh

  # Insertion of the keys in the directory, while applying the correct permissions and changing the owner
  echo "${var.key_pair_pem["vpn"].private_key_pem}" > /.ssh/${var.key_pair["vpn"]}.pem
  chmod 400 /.ssh/${var.key_pair["vpn"]}.pem
  chown -R ubuntu /.ssh

  # We add the VPN server IP to known hosts, we need this to auto confirm the scp command
  ssh-keyscan -H ${var.vpn_ip} | sudo tee -a ~/.ssh/known_hosts
  
  # Installation of the firewall, OpenVPN and AWS CLI to access the S3 bucket
  apt update -y
  apt install firewalld -y
  apt install awscli -y
  apt install openvpn -y

  # Application of the firewall rules
  firewall-cmd --zone=public --change-interface=eth0 --permanent
  firewall-cmd --zone=public --add-service=ssh --permanent
  firewall-cmd --zone=public --add-service=openvpn --permanent
  firewall-cmd --zone=public --add-port=1194/udp --permanent
  firewall-cmd --reload

  # Import of the client configuration file from the VPN server
  scp -i /.ssh/${var.key_pair["vpn"]}.pem ubuntu@${var.vpn_ip}:/home/ubuntu/client.ovpn /home/ubuntu/
  
  # Application of the client configuration file
  openvpn --config /home/ubuntu/client.ovpn
  EOF
   vpn = <<-EOF
  EOF
  test_ec2 = <<-EOF
  EOF
  }
}

locals {
  # Create a list of objets VPC, Subnets CIDR
  vpc_instances = flatten([
    for vpc_name, vpc_data in var.vpcs : [
      for subnet_name, subnet_data in vpc_data.subnets : [
        for instance_name, instance_data in subnet_data.instances : {
          vpc_name = vpc_name
          subnet_name = subnet_name
          subnet_cidr_block = subnet_data.cidr_block
          public = subnet_data.public
          instance_name = instance_name
          instance_ami = instance_data.ami
          instance_type = instance_data.type
          ports = instance_data.ports
        }if subnet_name != "vpn"
      ]
    ]
  ])
}
