# Guía de Contribución

## Flujo de Trabajo
1. Crea una rama desde `develop` para tu característica o corrección.
2. Realiza tus cambios siguiendo las convenciones del proyecto.
3. Envía un Pull Request a la rama `develop`.
4. Después de la revisión y aprobación, tus cambios serán fusionados.

## Convenciones de Código
- Sigue las prácticas recomendadas de Terraform.
- Documenta todos los módulos y recursos.
- Usa nombres descriptivos para variables y recursos.

## Pruebas
- Prueba tus cambios localmente antes de enviar un PR.
- Verifica que los flujos de CI/CD pasen correctamente.

## Despliegue
- Los cambios en `develop` se despliegan automáticamente en el entorno de desarrollo.
- Los cambios en `main` se despliegan automáticamente en el entorno de producción.