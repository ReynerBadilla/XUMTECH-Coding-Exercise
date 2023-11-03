resource "aws_dynamodb_table" "sms_messages" {
  name           = var.name
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key

  attribute {
    name = "messageId"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-sms-table"
    Environment = "production"
  }
}
