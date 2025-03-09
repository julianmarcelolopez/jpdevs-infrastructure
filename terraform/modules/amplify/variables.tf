variable "app_name" {
  description = "Nombre de la aplicación Amplify"
  type        = string
}

variable "repository_url" {
  description = "URL del repositorio GitHub (formato: https://github.com/usuario/repositorio)"
  type        = string
}

variable "github_access_token" {
  description = "Token de acceso personal de GitHub con permisos para el repositorio"
  type        = string
  sensitive   = true
}

variable "build_spec" {
  description = "Configuración de construcción personalizada (opcional)"
  type        = string
  default     = ""
}

variable "environment_variables" {
  description = "Variables de entorno comunes para todas las ramas"
  type        = map(string)
  default     = {}
}

variable "enable_auto_branch_creation" {
  description = "Habilitar la creación automática de ramas"
  type        = bool
  default     = false
}

variable "enable_branch_auto_build" {
  description = "Habilitar la construcción automática de ramas"
  type        = bool
  default     = true
}

variable "enable_branch_auto_deletion" {
  description = "Habilitar la eliminación automática de ramas cuando se eliminan en GitHub"
  type        = bool
  default     = false
}

variable "branches" {
  description = "Configuración de ramas específicas"
  type = map(object({
    framework               = string
    stage                   = string
    enable_auto_build       = bool
    enable_basic_auth       = bool
    basic_auth_credentials  = string
    environment_variables   = map(string)
  }))
  default = {}
}

variable "domain_name" {
  description = "Dominio personalizado (opcional)"
  type        = string
  default     = ""
}

variable "sub_domains" {
  description = "Configuración de subdominios para asociar a ramas"
  type = list(object({
    branch = string
    prefix = string
  }))
  default = []
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "branch_name" {
  description = "Nombre de la rama de GitHub a desplegar (ej: main, develop)"
  type        = string
}

