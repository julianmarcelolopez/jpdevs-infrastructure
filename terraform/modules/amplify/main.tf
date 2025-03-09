resource "aws_amplify_app" "jpdevs_frontend" {
  name = "jpdevs-frontend"
  repository = "https://github.com/julianmarcelolopez/jpdevs-front"
  access_token = var.github_access_token

  # Configuraciones de build actualizadas para coincidir con tu amplify.yml
  build_spec = <<-EOT
version: 1
frontend:
  phases:
    preBuild:
      commands:
        - npm ci
    build:
      commands:
        - npm run build
  artifacts:
    baseDirectory: dist
    files:
      - '**/*'
  cache:
    paths:
      - node_modules/**/*
      - .vite/**/*
EOT

  # Variables de entorno a nivel de aplicación
  environment_variables = {
    ENV = "production"
  }
}

# Definir las ramas como recursos separados
resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.jpdevs_frontend.id
  branch_name = "main"
  stage       = "PRODUCTION"
}

resource "aws_amplify_branch" "develop" {
  app_id      = aws_amplify_app.jpdevs_frontend.id
  branch_name = "develop"
  stage       = "DEVELOPMENT"
}