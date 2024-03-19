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

variable "index_html_filepath" {
  description = "Filepath to the index.html file"
  type        = string

  validation {
    condition = fileexists(var.index_html_filepath)
    error_message = "The specified index.html file does not exist"
  }
}

variable "error_html_filepath" {
  description = "Filepath to the error.html file"
  type        = string

  validation {
    condition = fileexists(var.error_html_filepath)
    error_message = "The specified error.html file does not exist"
  }
}

variable "content_version" {
  description = "The content version. Should be a positive integer starting at 1."
  type        = number

  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "The content_version must be a positive integer starting at 1."
  }
}