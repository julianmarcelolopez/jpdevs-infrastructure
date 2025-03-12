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

# Módulo Amplify (actualizado con configuración y variables de entorno)
module "amplify" {
  source = "../modules/amplify"

  app_name = "jpdevs-frontend"
  repository_url = "https://github.com/julianmarcelolopez/jpdevs-front"
  environment    = "dev"
  branch_name    = "develop"
  github_access_token = var.github_access_token

  # Agregando configuración de ramas y variables de entorno
  branches = {
    develop = {
      framework = "React"
      stage = "DEVELOPMENT"
      enable_auto_build = true
      enable_basic_auth = false
      basic_auth_credentials = ""
      environment_variables = {
        REACT_APP_MAIL_SENDER_URL = "https://dev-mail-sender.example.com/"  # Reemplaza con la URL correcta
        REACT_APP_QR_SCANNER_URL = "https://dev-qr-scanner.example.com/"    # Reemplaza con la URL correcta
        REACT_APP_API_URL = "https://api-dev.example.com/"                  # Agrega otras variables según sea necesario
        REACT_APP_ENV = "development"
      }
    }
  }
}

# Outputs
output "amplify_app_url" {
  value = module.amplify.branch_urls["develop"]
}

output "all_branch_urls" {
  value = module.amplify.branch_urls
}