resource "aws_s3_bucket" "website_bucket" {
    bucket = var.bucket_name

    tags = {
      UserUuid = var.user_uuid
      Hello = "mars"
  }
}


resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  # source = "${path.root}/public/index.html"
  source = "${path.root}${var.index_html_filepath}"
  content_type = "text/html"


  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = filemd5("${path.root}/public/index.html")
  etag = filemd5("${path.root}${var.index_html_filepath}")
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [ etag ]
  }
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  # source = "${path.root}/public/error.html"
  source = "${path.root}${var.error_html_filepath}"
  content_type = "text/html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = filemd5("${path.root}/public/error.html")
  etag = "${path.root}${var.error_html_filepath}"
  # lifecycle {
  #   replace_triggered_by = [terraform_data.content_version.output]
  #   ignore_changes = [ etag ]
  # }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.bucket

  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = {
        "Sid" = "AllowCloudFrontServicePrincipalReadOnly",
        "Effect" = "Allow",
        "Principal" = {
          "Service" = "cloudfront.amazonaws.com"
        },
        "Action" = "s3:GetObject",
        "Resource" ="arn:aws:s3:::${aws_s3_bucket.website_bucket.id}/*",
        "Condition" = {
          # "StringEquals" = {
          #   # "AWS:SourceArn" : "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
          #   "AWS:SourceArn": data.aws_caller_identity.current.arn
          # }
        }
      }
  })
}

resource "terraform_data" "content_version" {
  input = var.content_version
}

# fileset("${path.root}/public/assets/" ,"*.{jpg,png}")

resource "aws_s3_object" "upload_assets" {
  for_each = fileset("${path.root}/public/assets/", "*.{jpg,png,gif}")
  bucket   = aws_s3_bucket.website_bucket.bucket
  key      = "assets/${each.key}"
  source   = "${path.root}/public/assets/${each.key}"
  etag     = filemd5("${path.root}/public/assets/${each.key}")

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [etag]
  }
}
