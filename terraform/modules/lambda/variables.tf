variable "function_name" {
  description = "Nombre de la función Lambda"
  type        = string
  default     = "jpdevs-backend"
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "development"
}

variable "lambda_execution_role_arn" {
  description = "ARN del rol de ejecución de Lambda"
  type        = string
}

variable "code_bucket_name" {
  description = "Nombre del bucket S3 donde se almacena el código"
  type        = string
}

variable "code_version" {
  description = "Versión del código a desplegar"
  type        = string
  default     = "latest"
}