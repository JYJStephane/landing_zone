variable "vpcs" {
  type = map(object({
    cidr_block = string
    subnets = map(object({
      cidr_block = string
      public = bool
    }))
  }))
}