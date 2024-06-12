locals {
    # Crear una lista de objetos con nombre de VPC y CIDR
    vpc_subnets = flatten([
        for vpc_name, vpc_data in var.vpcs : [
            for subnet_name, subnet_data in vpc_data.subnets : {
                vpc_name = vpc_name
                cidr_block = subnet_data.cidr_block
                name = subnet_name
                data = subnet_data
                
            }
        ]
    ])
}