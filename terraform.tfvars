vpcs = {
  virginia = {
    cidr_block = "10.10.0.0/16"
    subnets = {
      primary = {
        cidr_block = "10.10.1.0/24"
        public = true
        instances = {
          apache = {
            ami  = "ami-0e001c9271cf7f3b9"
            type = "t2.micro"
            ports = {80 = "tcp", 443 = "tcp", 22 = "tcp", -1 = "icmp"}
          },
          mysql = {
            ami  = "ami-0e001c9271cf7f3b9"
            type = "t2.micro"
            ports = {80 = "tcp", 443 = "tcp", 22 = "tcp", -1 = "icmp"}
          }
        }
      }
      secondary = {
        cidr_block = "10.10.2.0/24"
        public = true
        instances = {
          monitoring = {
            ami  = "ami-0e001c9271cf7f3b9"
            type = "t2.micro"
            ports = {22 = "tcp", -1 = "icmp", 1194 = "udp"}
          }
        }
      }
    }
    
  }
  vpn = {
    cidr_block = "10.20.0.0/16"
    subnets = {
      vpn = {
        cidr_block = "10.20.1.0/24"
        public = true
        instances = {
          vpn = {
            ami  = "ami-0e001c9271cf7f3b9"
            type = "t2.micro"
            ports = {80 = "tcp", 443 = "tcp", 22 = "tcp", -1 = "icmp", 1194 = "udp"}
          }
        }
      }
    }
  }
  # test = {
  #   cidr_block = "10.30.0.0/16"
  #   subnets = {
  #     test_subnet = {
  #       cidr_block = "10.30.1.0/24"
  #       public = true
  #       instances = {
  #         test_ec2 = {
  #           ami  = "ami-0e001c9271cf7f3b9"
  #           type = "t2.micro"
  #           ports = {80 = "tcp", 443 = "tcp", 22 = "tcp", -1 = "icmp"}
  #         }
  #       }
  #     }
  #   }
  # }
}

# General tags that are added to most resources in the project
tags = {
  "env"         = "dev"
  "owner"       = "JYJ"
  "cloud"       = "AWS"
  "IaC"         = "Terraform"
  "IaC_Version" = "1.5.7"
  "project"     = "landing-zone"
  "region"      = "virginia"
}

# Users membership associations to groups
iam_users = {
  "admin_user"       = ["aws_admin"]
  "billing_user"     = ["aws_billing"]
  "security_user"    = ["aws_security"]
  "operations_user"  = ["aws_operations"]
  # "test_user"        = ["aws_operations"]
}

# List of Groups added to our configuration
iam_groups = [
  "aws_admin",
  "aws_billing",
  "aws_security",
  "aws_operations"
]

# Configuration data of the keys generated for our instances and their names
keys = {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Cube lifecycle configuration
bucket_config = {
  expiration  = 90
  glacier     = 60
  standard_ia = 30
}

# Data for dynamic budget creation
budgets = [
  {
    budget_name              = "ZeroSpendBudget"
    budget_limit_amount      = "1.00"
    budget_time_period_start = "2023-01-01_00:00"
    budget_time_period_end   = "2087-01-01_00:00"
    budget_notifications = [{
      comparison_operator               = "GREATER_THAN"
      notification_type                 = "ACTUAL"
      threshold                         = 10
      threshold_type                    = "PERCENTAGE"
      budget_subscriber_email_addresses = ["based@yopmail.com"]
      },
      {
        comparison_operator               = "GREATER_THAN"
        notification_type                 = "ACTUAL"
        threshold                         = 0.01
        threshold_type                    = "ABSOLUTE_VALUE"
        budget_subscriber_email_addresses = ["based@yopmail.com", "another@yopmail.com"]
      }
    ]
  },
  {
    budget_name              = "AnotherBudget"
    budget_limit_amount      = "500.00"
    budget_time_period_start = "2023-01-01_00:00"
    budget_time_period_end   = "2087-01-01_00:00"
    budget_notifications = [
      {
        comparison_operator               = "GREATER_THAN"
        notification_type                 = "ACTUAL"
        threshold                         = 50
        threshold_type                    = "PERCENTAGE"
        budget_subscriber_email_addresses = ["another@yopmail.com"]
      }
    ]
  }
]