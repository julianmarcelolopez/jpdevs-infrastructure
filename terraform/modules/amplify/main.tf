resource "aws_amplify_app" "jpdevs_frontend" {
  name = "jpdevs-frontend"
  repository = "https://github.com/julianmarcelolopez/jpdevs-front"

  # Configuraciones de build
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
    baseDirectory: build
    files:
      - '**/*'
  cache:
    paths:
      - node_modules/**/*
EOT

  # Configuración de ramas
  environment_variables = {
    ENV = "production"
  }

  # Configuraciones específicas de entorno
  dynamic "branch" {
    for_each = ["main", "develop"]
    content {
      branch_name = branch.value
      stage = branch.value == "main" ? "PRODUCTION" : "DEVELOPMENT"
    }
  }
}