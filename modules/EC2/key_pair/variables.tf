variable "keys" {
  description = "Valores para configurar nuestra generación de keys"
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