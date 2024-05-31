variable "cidr_map" {
  description = "Map of CIDR blocks for VPC, subnets, etc."
  type        = map(string)
}

variable "suffix" {
  description = "Suffix to append to resource names"
  type        = string
}

variable "ports" {
  description = "Map of ports used in security group"
  type = map(object({
    port     = number
    protocol = string
  }))
}

variable "key_name" {
  description = "Key pair name to access public instances"
  type        = string
}

variable "ec2_specs" {
  description = "EC2 specifications including AMI and instance type"
  type = object({
    ami            = string
    instance_type  = string
  })
}

variable "peering_id" {
  type = string
}
