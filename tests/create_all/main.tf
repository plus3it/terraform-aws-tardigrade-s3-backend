module "state_bucket" {
  source = "../../"

  backend_config = {
    bucket        = "test-bucket-for-backend"
    force_destroy = true
    versioning    = "Enabled"

    public_access_block = {
      block_public_acls       = true
      block_public_policy     = true
      ignore_public_acls      = true
      restrict_public_buckets = true
    }

    server_side_encryption_configuration = {
      bucket_key_enabled = true
      sse_algorithm      = "aws:kms"
      kms_master_key_id  = null
    }
    dynamodb_table = {
      name = "test-ddb-for-backend"
    }
  }
}
