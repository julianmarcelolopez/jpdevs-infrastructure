#!/bin/bash
set -e

ENVIRONMENT=$1
VERSION=$2

if [ -z "$ENVIRONMENT" ]; then
  echo "Uso: $0 <environment> [version]"
  echo "Ejemplo: $0 dev 0.1.0"
  exit 1
fi

if [ -z "$VERSION" ]; then
  VERSION="latest"
fi

echo "Desplegando backend en ambiente $ENVIRONMENT con versión $VERSION"

# Inicializar Terraform
cd terraform/$ENVIRONMENT
terraform init

# Actualizar variable de versión
sed -i "s/code_version.*/code_version    = \"$VERSION\"/" terraform.tfvars

# Aplicar configuración
terraform apply -auto-approve

echo "Despliegue completado"