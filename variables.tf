variable "backend_config" {
  description = "Object of S3 backend config"
  type = object({
    bucket        = string
    force_destroy = optional(bool, true)
    versioning    = optional(string, "Enabled")
    policy = optional(object({
      json = string
    }))
    public_access_block = optional(object({
      block_public_acls       = optional(bool, true)
      block_public_policy     = optional(bool, true)
      ignore_public_acls      = optional(bool, true)
      restrict_public_buckets = optional(bool, true)
    }), {})
    server_side_encryption_configuration = optional(object({
      bucket_key_enabled = optional(bool, true)
      sse_algorithm      = optional(string, "aws:kms")
      kms_master_key_id  = optional(string)
    }), {})
    dynamodb_table = object({
      name                        = string
      deletion_protection_enabled = optional(bool, true)
      billing_mode                = optional(string, "PAY_PER_REQUEST")
    })
  })
}

variable "tags" {
  description = "The tags applied to the bucket"
  type        = map(string)
  default     = {}
}