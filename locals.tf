# Create an 8-character variable suffix to assign the name to our bucket 
# (No two buckets can exist with the same name)
resource "random_string" "sufijo-s3" {
  length  = 8
  special = false
  upper   = false
}

# Random suffix for the bucket
locals {
  s3-sufix = "vpc-flow-logs-${random_string.sufijo-s3.id}"

  cidr = {
    any        = "0.0.0.0/0"
    virginia   = "10.10.0.0/16"
    vpn        = "10.20.0.0/16"
    public     = "10.10.1.0/24"
    private    = "10.10.2.0/24"
    vpn_subnet = "10.20.1.0/24"
  }
}

