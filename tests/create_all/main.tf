module "state_bucket" {
  source = "../../"

  backend_config = {
    bucket = "test-bucket-for-backend"

    dynamodb_table = {
      name = "test-ddb-for-backend"
    }
  }
}
