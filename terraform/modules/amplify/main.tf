resource "aws_amplify_app" "frontend_app" {
  name         = var.app_name
  repository   = var.repository_url
  access_token = var.github_access_token

  build_spec = var.build_spec != "" ? var.build_spec : <<-EOT
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

  environment_variables = var.environment_variables

  platform = "WEB"
  enable_auto_branch_creation = var.enable_auto_branch_creation
  enable_branch_auto_build    = var.enable_branch_auto_build
  enable_branch_auto_deletion = var.enable_branch_auto_deletion
}

# Rama principal (la que se define en la variable branch_name)
resource "aws_amplify_branch" "frontend_branch" {
  app_id      = aws_amplify_app.frontend_app.id
  branch_name = var.branch_name

  framework          = try(var.branches[var.branch_name].framework, "React")
  stage              = try(var.branches[var.branch_name].stage, var.environment == "prod" ? "PRODUCTION" : "DEVELOPMENT")
  enable_auto_build  = try(var.branches[var.branch_name].enable_auto_build, true)

  environment_variables = try(var.branches[var.branch_name].environment_variables, {})
}

# Ramas adicionales definidas en la variable branches
resource "aws_amplify_branch" "additional_branches" {
  for_each = {
    for name, config in var.branches : name => config
    if name != var.branch_name  # Excluimos la rama principal que ya se creó arriba
  }

  app_id      = aws_amplify_app.frontend_app.id
  branch_name = each.key

  framework          = each.value.framework
  stage              = each.value.stage
  enable_auto_build  = each.value.enable_auto_build

  environment_variables = each.value.environment_variables
}