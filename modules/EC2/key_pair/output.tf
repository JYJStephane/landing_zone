output "key_pair_pem" {
  description = "Map of the keys to enter instances by ssh"
  value = tls_private_key.tls_key_pair
}

output "key_pair" {
  description = "Key Pairs of our instances"
  value = {for key, value in aws_key_pair.key_pair : key => value.key_name}
}
