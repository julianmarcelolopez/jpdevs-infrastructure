# terraform/dev/main.tf

provider "aws" {
  region = var.aws_region
}

# Módulo IAM (mantenido como estaba)
module "iam" {
  source = "../modules/iam"

  environment = "dev"
  dynamodb_table_arns = ["arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:table/jpdevs-table-dev"]
}

# Módulo Lambda (mantenido como estaba)
module "lambda" {
  source = "../modules/lambda"

  function_name           = "jpdevs-backend"
  environment             = "dev"
  lambda_execution_role_arn = module.iam.lambda_execution_role_arn
  code_bucket_name        = var.code_bucket_name
  code_version            = var.code_version
}

# Módulo Amplify (actualizado con configuración específica)
module "amplify" {
  source = "../modules/amplify"

  app_name = "jpdevs-front-dev"  # O podrías usar una variable: "jpdevs-front-${var.environment}"
  repository_url = "https://github.com/julianmarcelolopez/jpdevs-front"
  environment    = "dev"
  branch_name    = "develop"
  github_access_token = var.github_access_token
}

# Outputs
output "amplify_app_url" {
  value = module.amplify.branch_urls["develop"]
}