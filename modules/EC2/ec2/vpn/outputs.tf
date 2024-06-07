# Output to get the public IP of the VPN instance
output "vpn_ip" {
  description = "Sending out to the my instance module to use the ip in bootstraps"
  value = aws_instance.vpn.public_ip
}

# Output to get the arn of the VPN instance
output "vpn_arn" {
  description = "Sending out to the my instance module to use the ip in bootstraps"
  value = aws_instance.vpn.arn
}