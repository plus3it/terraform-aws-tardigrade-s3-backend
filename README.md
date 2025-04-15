# terraform-aws-tardigrade-s3-backend
Repo to manage S3 backend


<!-- BEGIN TFDOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_config"></a> [backend\_config](#input\_backend\_config) | Object of S3 backend config | <pre>object({<br/>    bucket        = string<br/>    force_destroy = optional(bool, true)<br/>    versioning    = optional(string, "Enabled")<br/>    policy = optional(object({<br/>      json = string<br/>    }))<br/>    public_access_block = optional(object({<br/>      block_public_acls       = optional(bool, true)<br/>      block_public_policy     = optional(bool, true)<br/>      ignore_public_acls      = optional(bool, true)<br/>      restrict_public_buckets = optional(bool, true)<br/>    }), {})<br/>    server_side_encryption_configuration = optional(object({<br/>      bucket_key_enabled = optional(bool, true)<br/>      sse_algorithm      = optional(string, "aws:kms")<br/>      kms_master_key_id  = optional(string)<br/>    }), {})<br/>    dynamodb_table = object({<br/>      name                        = string<br/>      deletion_protection_enabled = optional(bool, true)<br/>      billing_mode                = optional(string, "PAY_PER_REQUEST")<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags applied to the bucket | `map(string)` | `{}` | no |

## Outputs

No outputs.

<!-- END TFDOCS -->
