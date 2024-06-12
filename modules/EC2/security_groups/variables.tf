variable "ports" {
  description = "Ports & Protocols"
  type = map(object({
    ingress = map(object({
      from_port = number
      to_port   = number
      protocol  = string
    }))
    egress = object({
      from_port = number
      to_port   = number
      protocol  = string
    })
  }))
  
}


variable "vpc_ids" {
  description = "ID VPC Virginia"
  type        = map(string)
}