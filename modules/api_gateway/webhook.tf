resource "aws_lambda_function" "lambda_webhook" {
  filename      = "${path.root}/resources/webhook/webhook.zip"
  function_name = var.webhook_function_name
  role          = aws_iam_role.iam_for_webhook.arn
  handler       = var.webhook_handler
  runtime       = var.lambda_runtime
  timeout       = var.lambda_timeout
}

resource "aws_cloudwatch_log_group" "lambda_webhook" {
  name = "/aws/lambda/${aws_lambda_function.lambda_webhook.function_name}"
  retention_in_days = var.cw_log_retention
}



