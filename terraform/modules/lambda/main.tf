resource "aws_lambda_function" "jpdevs_backend" {
  function_name = "jpdevs-backend-${var.environment}"
  role          = var.lambda_execution_role_arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  timeout       = 30
  memory_size   = 256

  s3_bucket     = var.code_bucket_name
  s3_key        = "lambda/${var.function_name}/${var.code_version}/function.zip"

  environment {
    variables = {
      ENV = var.environment
    }
  }

  tags = {
    Environment = var.environment
    Project     = "JPDevs"
  }
}