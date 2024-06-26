output "bucket_name" {
    value = aws_s3_bucket.website_bucket
}

output "website_endpoint" {
    description = "s3 static website"
    value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name 
}