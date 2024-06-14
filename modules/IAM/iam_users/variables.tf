variable "iam_users" {
  description = "IAM users"
  type = map(set(string))
}

variable "iam_groups" {
  description = "Groups map"
  type = list(string)
}
