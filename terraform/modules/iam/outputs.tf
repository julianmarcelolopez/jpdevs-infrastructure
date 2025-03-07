output "lambda_execution_role_arn" {
  description = "ARN del rol de ejecución para Lambda"
  value       = aws_iam_role.lambda_execution_role.arn
}

output "lambda_execution_role_name" {
  description = "Nombre del rol de ejecución para Lambda"
  value       = aws_iam_role.lambda_execution_role.name
}

output "lambda_policy_arn" {
  description = "ARN de la política para Lambda"
  value       = aws_iam_policy.lambda_policy.arn
}