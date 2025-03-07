variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "development"
}

variable "dynamodb_table_arns" {
  description = "Lista de ARNs de tablas DynamoDB a las que Lambda tendrá acceso"
  type        = list(string)
  default     = []
}