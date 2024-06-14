variable "keys" {
  description = "Generation key values"
  type = object({
    algorithm = string 
    rsa_bits = number
  })
}

variable "vpcs" {
  type = map(object({
    cidr_block = string
    subnets = map(object({
      cidr_block = string
      public = bool
    }))
  }))
}