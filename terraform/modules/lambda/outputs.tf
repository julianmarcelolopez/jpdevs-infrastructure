output "function_arn" {
  description = "ARN de la función Lambda"
  value       = aws_lambda_function.jpdevs_backend.arn
}

output "function_name" {
  description = "Nombre de la función Lambda"
  value       = aws_lambda_function.jpdevs_backend.function_name
}

output "invoke_arn" {
  description = "ARN de invocación de la función Lambda"
  value       = aws_lambda_function.jpdevs_backend.invoke_arn
}