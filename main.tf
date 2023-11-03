terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "aws_dynamodb" {
  source      = "./modules/dynamo"
}

module "lambda_api" {
  source      = "./modules/api_gateway"
}