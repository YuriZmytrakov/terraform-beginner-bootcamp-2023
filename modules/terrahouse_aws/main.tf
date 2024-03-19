terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.41.0"
        }
    }
}

# provider "aws" {
# }

data "aws_caller_identity" "current" {}
