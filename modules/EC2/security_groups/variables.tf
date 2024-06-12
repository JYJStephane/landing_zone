variable "vpc_ids" {
  description = "ID VPC Virginia"
  type        = map(string)
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