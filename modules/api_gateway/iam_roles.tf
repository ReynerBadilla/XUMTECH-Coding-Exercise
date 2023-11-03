# IAM Role for Lambda
resource "aws_iam_role" "iam_for_api" {
  name = "LambdaAPIRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Principal": {
            "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "iam_for_api_policy" {
  name   = "iam_for_api_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:us-east-1:201138032438:log-group:/aws/lambda/api:*"
      },
      {
        "Effect": "Allow",
        "Action": ["dynamodb:GetItem","dynamodb:Scan"],
        "Resource": "arn:aws:dynamodb:us-east-1:201138032438:table/messages"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "policy_attachment_api" {
  name       = "attachmentLambdaAPI"
  roles      = ["${aws_iam_role.iam_for_api.name}"]
  policy_arn = aws_iam_policy.iam_for_api_policy.arn
}

resource "aws_lambda_permission" "api_gateway_invoke_api" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "api"
  principal     = "apigateway.amazonaws.com"

  depends_on = [aws_lambda_function.lambda_api]

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/GET/api-search"
}

######### IAM Role for Lambda ##########

resource "aws_iam_role" "iam_for_webhook" {
  name = "LambdaWebhookRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Principal": {
            "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "iam_for_webhook_policy" {
  name   = "iam_for_webhook_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:us-east-1:201138032438:log-group:/aws/lambda/webhook:*"
      },
      {
        "Effect": "Allow",
        "Action": "dynamodb:PutItem",
        "Resource": "arn:aws:dynamodb:us-east-1:201138032438:table/messages"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "policy_attachment_webhook" {
  name       = "attachmentLambdaWebhook"
  roles      = ["${aws_iam_role.iam_for_webhook.name}"]
  policy_arn = aws_iam_policy.iam_for_webhook_policy.arn
}

resource "aws_lambda_permission" "api_gateway_invoke_webhook" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "webhook"
  principal     = "apigateway.amazonaws.com"

  depends_on = [aws_lambda_function.lambda_webhook]

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/POST/sms-webhook"
}