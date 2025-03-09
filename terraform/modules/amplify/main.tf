resource "aws_amplify_app" "frontend_app" {
  name         = "jpdevs-front-${var.environment}"
  repository   = var.repository_url
  access_token = var.github_access_token

  # Configuración de construcción según tu amplify.yml actual
  build_spec = <<-EOT
version: 1
frontend:
  phases:
    preBuild:
      commands:
        - 'npm ci --cache .npm --prefer-offline'
    build:
      commands:
        - 'npm run build'
  artifacts:
    baseDirectory: dist
    files:
      - '**/*'
  cache:
    paths:
      - '.npm/**/*'
EOT

  # Variables de entorno comunes a todas las ramas
  environment_variables = {
    REACT_APP_MAIL_SENDER_URL = var.environment == "prod" ? "https://main.d13c67jud9spm1.amplifyapp.com/" : "https://develop.d13c67jud9spm1.amplifyapp.com/"
    REACT_APP_QR_SCANNER_URL = var.environment == "prod" ? "https://main.d8eci5asqo38h.amplifyapp.com/" : "https://develop.d8eci5asqo38h.amplifyapp.com/"
  }

  # Configuración de plataforma
  platform = "WEB"

  # Configuración automática de ramas
  enable_auto_branch_creation = false
  enable_branch_auto_build    = true
  enable_branch_auto_deletion = false
}

# Configuración de la rama específica
resource "aws_amplify_branch" "frontend_branch" {
  app_id      = aws_amplify_app.frontend_app.id
  branch_name = var.branch_name

  framework          = "React"
  stage              = var.environment == "prod" ? "PRODUCTION" : "DEVELOPMENT"
  enable_auto_build  = true

  # Variables de entorno específicas de rama
  environment_variables = var.environment == "prod" ? {} : {
    REACT_APP_MAIL_SENDER_URL = "https://develop.d13c67jud9spm1.amplifyapp.com/"
    REACT_APP_QR_SCANNER_URL = "https://develop.d8eci5asqo38h.amplifyapp.com/"
  }
}