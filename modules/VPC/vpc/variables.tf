variable "cidr_map" {
  description = "Map of CIDR blocks for VPC, subnets, etc."
  type        = map(string)
}

variable "vpcs" {
  description = "Map of vpcs"
  type = map(string)
}

variable "subnets" {
  description = "Map for subnets"
  type = map(object({
    vpc  = string
    cidr = string
  }))
}