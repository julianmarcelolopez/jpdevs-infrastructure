output "app_id" {
  description = "ID de la aplicación Amplify"
  value       = aws_amplify_app.frontend_app.id
}

output "app_default_domain" {
  description = "Dominio predeterminado de Amplify"
  value       = aws_amplify_app.frontend_app.default_domain
}

output "app_arn" {
  description = "ARN de la aplicación Amplify"
  value       = aws_amplify_app.frontend_app.arn
}

output "branch_urls" {
  description = "URLs de cada rama"
  value = {
    for branch in aws_amplify_branch.frontend_branch :
    branch.branch_name => "${branch.branch_name}.${aws_amplify_app.frontend_app.default_domain}"
  }
}