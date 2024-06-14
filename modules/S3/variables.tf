variable "bucket_name" {
  description = "Bucket name"
  type = string
}

variable "instance_arn" {
  description = "Instance ARN"
  type = string
}

variable "config_time"{
  description = "Days count to the rule bucket expiration"
  type = map(number)
}