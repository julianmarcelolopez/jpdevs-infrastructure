# terraform/prod/main.tf

provider "aws" {
  region = var.aws_region
}

# Módulo IAM
module "iam" {
  source = "../modules/iam"

  environment = "prod"
  dynamodb_table_arns = ["arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:table/jpdevs-table-prod"]
}

# Módulo Lambda
module "lambda" {
  source = "../modules/lambda"

  function_name           = "jpdevs-backend"
  environment             = "prod"
  lambda_execution_role_arn = module.iam.lambda_execution_role_arn
  code_bucket_name        = var.code_bucket_name
  code_version            = var.code_version
}

# Módulo Amplify
module "amplify" {
  source = "../modules/amplify"

  app_name = "jpdevs-frontend"  # Mantener el mismo nombre de la aplicación
  repository_url = "https://github.com/julianmarcelolopez/jpdevs-front"
  environment    = "prod"
  branch_name    = "main"
  github_access_token = var.github_access_token

  # Si tu módulo de amplify soporta la configuración de múltiples ramas
  branches = {
    main = {
      framework = "React"
      stage = "PRODUCTION"
      enable_auto_build = true
      enable_basic_auth = false
      basic_auth_credentials = ""
      environment_variables = {}
    },
    develop = {
      framework = "React"
      stage = "DEVELOPMENT"
      enable_auto_build = true
      enable_basic_auth = false
      basic_auth_credentials = ""
      environment_variables = {
        REACT_APP_MAIL_SENDER_URL = "https://develop.d13c67jud9spm1.amplifyapp.com/"
        REACT_APP_QR_SCANNER_URL = "https://develop.d8eci5asqo38h.amplifyapp.com/"
      }
    }
  }
}

# Outputs
output "amplify_app_url" {
  value = module.amplify.branch_urls["main"]
}

output "all_branch_urls" {
  value = module.amplify.branch_urls
}