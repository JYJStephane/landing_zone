variable "instance_name" {
  description = "Names for the public instances"
  type        = set(string)
}

variable "ec2_specs" {
  description = "EC2 specifications including AMI and instance type"
  type = object({
    ami           = string
    instance_type = string
  })
}

variable "public_subnet_id" {
  description = "Public subnet ID where instances will be launched"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID where instances will be launched"
  type        = string
}

variable "public_sg_id" {
  description = "Security group ID to associate with public instances"
  type        = string
}

variable "private_sg_id" {
  description = "Security group ID to associate with private instances"
  type        = string
}

variable "enable_monitoring" {
  description = "Enable or disable monitoring instance"
  type        = bool
}

variable "suffix" {
  description = "Suffix to append to instance names"
  type        = string
}

variable "keys" {
  description = "Keys configuration values"
  type = object({
    algorithm = string
    rsa_bits  = number
    key_name  = map(string)
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
