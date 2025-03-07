variable "repository_url" {
  description = "URL del repositorio de GitHub"
  type        = string
  default     = "https://github.com/julianmarcelolopez/jpdevs-front"
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "development"
}

variable "branch_name" {
  description = "Nombre de la rama a desplegar"
  type        = string
  default     = "develop"
}