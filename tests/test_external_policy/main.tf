module "state_bucket" {
  source = "../../"

  backend_config = {
    bucket = local.bucket_name
    policy = local.policy

    dynamodb_table = {
      name = local.ddb_name

      deletion_protection_enabled = false
    }

    tags = {
      environment = "testing"
    }
  }
}

resource "random_string" "this" {
  length  = 8
  upper   = false
  special = false
  numeric = false
}

locals {
  id = random_string.this.result

  bucket_name = "test-bucket-for-backend-${local.id}"
  ddb_name    = "test-ddb-for-backend-${local.id}"

  policy = {
    json = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "MustBeEncryptedInTransit",
          "Effect" : "Deny",
          "Principal" : "*",
          "Action" : "s3:*",
          "Resource" : [
            "arn:${data.aws_partition.current.partition}:s3:::${local.bucket_name}",
            "arn:${data.aws_partition.current.partition}:s3:::${local.bucket_name}/*"
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
            "arn:${data.aws_partition.current.partition}:s3:::${local.bucket_name}",
            "arn:${data.aws_partition.current.partition}:s3:::${local.bucket_name}/*"
          ]
        },
        {
          "Sid" : "DenyS3DeleteObject",
          "Action" : [
            "s3:DeleteObject"
          ],
          "Effect" : "Deny",
          "Resource" : [
            "arn:${data.aws_partition.current.partition}:s3:::${local.bucket_name}/*"
          ],
          "Principal" : "*"
        }
      ]
    })
  }
}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}
