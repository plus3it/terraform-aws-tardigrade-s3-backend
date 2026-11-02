# Agent Instructions

Before starting any task in this repository:

1. Run `make agents/sync`. It writes the shared Plus3 IT instructions for this repository's tardigrade-ci version to `.agents/plus3it/AGENTS.md`.
2. Read `.agents/plus3it/AGENTS.md` and follow it together with this file. If the sync fails, tell the user, and don't guess the conventions.

These rules always apply, even without the shared instructions:

- Don't push, open pull requests, publish releases, or apply infrastructure changes unless the user asks. List those steps for a person in your final report.
- Don't edit files under `.agents/plus3it/`; they are generated and overwritten by the sync.

@.agents/plus3it/AGENTS.md

## Repository-specific

### Purpose

This Terraform module creates the storage for a Terraform S3 backend: an S3 bucket, made with the Plus3 IT `terraform-aws-tardigrade-s3-bucket` module, and a DynamoDB table with a `LockID` hash key. The only input is the `backend_config` object, which sets the bucket, the DynamoDB table, and optional bucket settings such as versioning, encryption, public access block, tags, and a bucket policy. Unless `policy` is set, the bucket gets a default policy that requires TLS, allows the account root, and denies `s3:DeleteObject`. The module has no outputs.
