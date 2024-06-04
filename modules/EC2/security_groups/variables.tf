variable "cidr_map" {
  description = "Map of CIDR blocks for VPC, subnets, etc."
  type        = map(string)
}

variable "ports" {
  description = "Map of ports used in security group"
  type = map(object({
    port     = number
    protocol = string
  }))
}

variable "vpc_ids" {
  description = "ID VPC Virginia"
  type = map(string)
}

variable "private_ip" {
  description = "Private IP of jumpserver"
  type = string
}