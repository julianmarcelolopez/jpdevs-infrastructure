#!/bin/bash
set -e

ENVIRONMENT=$1
BRANCH=$2

if [ -z "$ENVIRONMENT" ]; then
  echo "Uso: $0 <environment> [branch]"
  echo "Ejemplo: $0 dev develop"
  exit 1
fi

if [ -z "$BRANCH" ]; then
  if [ "$ENVIRONMENT" == "dev" ]; then
    BRANCH="develop"
  else
    BRANCH="main"
  fi
fi

echo "Desplegando frontend en ambiente $ENVIRONMENT desde rama $BRANCH"

# Inicializar Terraform
cd terraform/$ENVIRONMENT
terraform init

# Aplicar configuración
terraform apply -auto-approve

echo "Despliegue completado"