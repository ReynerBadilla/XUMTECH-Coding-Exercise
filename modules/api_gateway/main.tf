resource "aws_api_gateway_rest_api" "api" {
  name        = "SMSWebhook-API"
  description = "API Gateway for SMS Webhook and API"
}

###################### Resources for SMS webhook ######################

resource "aws_api_gateway_resource" "sms_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "sms-webhook"
}

resource "aws_api_gateway_method" "sms_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.sms_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration_webhook" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.sms_resource.id
  http_method             = aws_api_gateway_method.sms_post_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_webhook.invoke_arn
}

###################### Resources for API Search ######################

resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "api-search"
}

resource "aws_api_gateway_method" "api_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration_api" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.api_resource.id
  http_method             = aws_api_gateway_method.api_get_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_api.invoke_arn
}

#################### Deployment of the API Gateway ####################

resource "aws_api_gateway_deployment" "webhook_deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration_webhook,
    aws_api_gateway_integration.lambda_integration_api
  ]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}
