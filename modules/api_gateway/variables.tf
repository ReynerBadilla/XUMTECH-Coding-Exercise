variable "api_function_name" {
  description = "Name of the Lambda function."
  default     = "api"
}

variable "api_handler" {
  description = "Handler for the Lambda function."
  default     = "api.handler"
}

variable "lambda_runtime" {
  description = "Runtime for the Lambda function."
  default     = "nodejs14.x"
}

variable "lambda_timeout" {
  description = "Timeout for the Lambda function."
  default     = 120
}

variable "cw_log_retention" {
  description = "Number of days to retain CloudWatch logs."
  default     = 3
}

variable "webhook_function_name" {
  description = "Name of the Lambda function."
  default     = "webhook"
}

variable "webhook_handler" {
  description = "Handler for the Lambda function."
  default     = "webhook.handler"
}


