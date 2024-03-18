terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.41.0"
        }
    }
}

provider "aws" {
}

resource "aws_s3_bucket" "website_bucket" {
    bucket = var.bucket_name

    tags = {
      UserUuid = var.user_uuid
  }
}

