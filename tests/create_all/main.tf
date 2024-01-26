module "state_bucket" {
  source = "../../"

  backend_config = {
    bucket = "test-bucket-for-backend-${local.id}"

    dynamodb_table = {
      name = "test-ddb-for-backend-${local.id}"

      deletion_protection_enabled = false
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
}
