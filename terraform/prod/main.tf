provider "aws" {
  region = var.aws_region
}

module "iam" {
  source = "../modules/iam"

  environment = "prod"
  dynamodb_table_arns = ["arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:table/jpdevs-table-prod"]
}

module "lambda" {
  source = "../modules/lambda"

  function_name           = "jpdevs-backend"
  environment             = "prod"
  lambda_execution_role_arn = module.iam.lambda_execution_role_arn
  code_bucket_name        = var.code_bucket_name
  version                 = var.code_version
}

module "amplify" {
  source = "../modules/amplify"

  repository_url = "https://github.com/julianmarcelolopez/jpdevs-front"
  environment    = "prod"
  branch_name    = "main"
}