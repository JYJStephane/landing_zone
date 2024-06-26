variable "tags" {
  description = "Generally tags"
  type        = map(string)
}

variable "iam_users" {
  description = "Users map and their assignments"
  type        = map(set(string))
}

variable "iam_groups" {
  description = "Groups map"
  type        = list(string)
}

variable "bucket_config" {
  description = "Configuration values of the bucket lifecycle"
  type        = map(number)
}

variable "access_key" {
  description = "Access key for Terraform Cloud"
}

variable "secret_key" {
  description = "Secret key for Terraform Cloud"
}

variable "budgets" {
  description = "List of budgets and their configurations"
  type = list(object({
    budget_name              = string
    budget_limit_amount      = string
    budget_time_period_start = string
    budget_time_period_end   = string
    budget_notifications = list(object({
      comparison_operator               = string
      notification_type                 = string
      threshold                         = number
      threshold_type                    = string
      budget_subscriber_email_addresses = list(string)
    }))
  }))
}

variable "keys" {
  description = "Configuration values to generate keys"
  type = object({
    algorithm = string
    rsa_bits  = number
  })
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
