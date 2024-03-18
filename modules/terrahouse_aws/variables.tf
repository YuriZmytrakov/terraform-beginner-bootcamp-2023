variable "user_uuid" {
  description = "The user uuid"
  type        = string

  validation {
    condition     = can(regex("^([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})$", var.user_uuid))
    error_message = "The UUID value is not valid"
  }
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string

  validation {
    condition     = can(regex("^([a-z0-9-.]+)$", var.bucket_name))
    error_message = "The bucket name must contain only lowercase letters, numbers, hyphens, and periods."
  }
}
