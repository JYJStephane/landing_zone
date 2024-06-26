locals {
  # Create a list with the variables we need in this module from the great VPC variable
  sg_ports = flatten([
    for vpc_name, vpc_data in var.vpcs : [
      for subnet_name, subnet_data in vpc_data.subnets : [
        for instance_name, instance_data in subnet_data.instances : {
          vpc_name = vpc_name
          instance_name = instance_name
          ports = instance_data.ports
        }
      ]
    ]
  ])
}