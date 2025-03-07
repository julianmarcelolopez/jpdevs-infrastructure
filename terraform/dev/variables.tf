variable "aws_region" {
  description = "Región de AWS a utilizar"
  type        = string
  default     = "us-east-1"
}

variable "aws_account_id" {
  description = "ID de la cuenta de AWS"
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