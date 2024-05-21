resource "aws_iam_user" "users" {
  for_each = var.iam_users
  name = each.key
}

resource "aws_iam_user_group_membership" "user_group_memberships" {
  for_each = var.iam_users
  user = aws_iam_user.users[each.key].name
  groups = each.value
}

resource "aws_iam_access_key" "access_key" {
  for_each = var.iam_users
  user = aws_iam_user.users[each.key].name
}

output "user_access_key" {
  value = {
    for user, key in aws_iam_access_key.access_key :
    user => {
      access_key_id     = key.id
      secret_access_key = key.secret
    }
  }
  sensitive = true
}
