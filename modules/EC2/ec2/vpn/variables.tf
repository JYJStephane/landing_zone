variable "subnet_ids" {
  description = "Public subnet ID where instances will be launched"
  type        = map(string)
}

variable "sg_ids" {
  description = "Security group ID to associate with public instances"
  type        = map(string)
}

variable "keys" {
  description = "Keys configuration values"
  type = object({
    algorithm = string
    rsa_bits  = number
  })
}

variable "key_pair_pem" {
  description = "Name Key Pair Public"
  type = map(object({
    algorithm          = string
    rsa_bits           = number
    private_key_pem    = string
    public_key_openssh = string
    public_key_pem     = string
  }))
}

variable "vpcs" {
  type = map(object({
    cidr_block = string
    subnets = map(object({
      cidr_block = string
      public = bool
      instances = map(object({
        ami = string
        type = string
        ports = map(string)
      }))
    }))
  }))
}

variable "key_pair" {
  description = "Name of the key pairs"
  type = map(string)
}