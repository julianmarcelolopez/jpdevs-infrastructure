output "app_id" {
  description = "ID de la aplicación Amplify"
  value       = aws_amplify_app.jpdevs_frontend.id
}

output "app_url" {
  description = "URL de la aplicación desplegada"
  value       = aws_amplify_app.jpdevs_frontend.default_domain
}

output "app_name" {
  description = "Nombre de la aplicación Amplify"
  value       = aws_amplify_app.jpdevs_frontend.name
}