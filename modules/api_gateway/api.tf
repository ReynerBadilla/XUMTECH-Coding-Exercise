
resource "aws_lambda_function" "lambda_api" {
  filename      = "${path.root}/resources/api/api.zip"
  function_name = var.api_function_name
  role          = aws_iam_role.iam_for_api.arn
  handler       = var.api_handler
  runtime       = var.lambda_runtime
  timeout       = var.lambda_timeout
}

resource "aws_cloudwatch_log_group" "lambda_api" {
  name = "/aws/lambda/${aws_lambda_function.lambda_api.function_name}"
  retention_in_days = var.cw_log_retention
}

