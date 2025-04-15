module "state_bucket" {
  source        = "git::https://github.com/plus3it/terraform-aws-tardigrade-s3-bucket.git?ref=5.0.0"
  bucket        = var.backend_config.bucket
  force_destroy = var.backend_config.force_destroy
  versioning    = var.backend_config.versioning
  tags          = var.tags

  public_access_block = var.backend_config.public_access_block

  server_side_encryption_configuration = var.backend_config.server_side_encryption_configuration

  policy = var.backend_config.policy != null ? var.backend_config.policy : {
    json = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "EnforcedTLS",
          "Effect" : "Deny",
          "Principal" : "*",
          "Action" : "s3:*",
          "Resource" : [
            "arn:${data.aws_partition.current.partition}:s3:::${var.backend_config.bucket}",
            "arn:${data.aws_partition.current.partition}:s3:::${var.backend_config.bucket}/*"
          ],
          "Condition" : {
            "Bool" : {
              "aws:SecureTransport" : "false"
            }
          }
        },
        {
          "Sid" : "RootAccess",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
          },
          "Action" : "s3:*",
          "Resource" : [
            "arn:${data.aws_partition.current.partition}:s3:::${var.backend_config.bucket}",
            "arn:${data.aws_partition.current.partition}:s3:::${var.backend_config.bucket}/*"
          ]
        },
        {
          "Sid" : "DenyS3DeleteObject",
          "Action" : [
            "s3:DeleteObject"
          ],
          "Effect" : "Deny",
          "Resource" : [
            "arn:${data.aws_partition.current.partition}:s3:::${var.backend_config.bucket}/*"
          ],
          "Principal" : "*"
        }
      ]
    })
  }
}

resource "aws_dynamodb_table" "this" {
  name                        = var.backend_config.dynamodb_table.name
  deletion_protection_enabled = var.backend_config.dynamodb_table.deletion_protection_enabled
  billing_mode                = var.backend_config.dynamodb_table.billing_mode
  hash_key                    = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}
