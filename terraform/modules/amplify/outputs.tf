output "branch_urls" {
  description = "URLs para todas las ramas de Amplify"
  value = merge(
    {
      (var.branch_name) = "${var.branch_name}.${aws_amplify_app.frontend_app.default_domain}"
    },
    {
      for name, _ in aws_amplify_branch.additional_branches :
      name => "${name}.${aws_amplify_app.frontend_app.default_domain}"
    }
  )
}

output "main_branch_url" {
  description = "URL para la rama principal configurada"
  value = "${var.branch_name}.${aws_amplify_app.frontend_app.default_domain}"
}