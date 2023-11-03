variable "name" {
  description = "The name of the resource"
  default     = "messages"
}

variable "billing_mode" {
  description = "The billing mode for the DynamoDB table"
  default     = "PROVISIONED"
}

variable "read_capacity" {
  description = "The number of read capacity units for the DynamoDB table"
  default     = 4
}

variable "write_capacity" {
  description = "The number of write capacity units for the DynamoDB table"
  default     = 4
}

variable "hash_key" {
  description = "The attribute name that is used as the partition key for the DynamoDB table."
  default     = "messageId"
}
