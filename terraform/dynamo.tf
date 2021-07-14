resource "aws_dynamodb_table" "ddbtable" {
  name             = "users"
  hash_key         = "ID"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  attribute {
    name = "ID"
    type = "S"
  }
}