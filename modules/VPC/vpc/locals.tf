locals {
    # Create a list with the variables we need in this module from the great VPC variable
    vpc_subnets = flatten([
        for vpc_name, vpc_data in var.vpcs : [
            for subnet_name, subnet_data in vpc_data.subnets : {
                vpc_name = vpc_name
                name = subnet_name
                data = subnet_data               
            }
        ]
    ])
}