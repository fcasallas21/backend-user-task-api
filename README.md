## Integración Continua (CI) con Jenkins

Este proyecto incluye un archivo `Jenkinsfile` que permite ejecutar un pipeline de CI con los siguientes pasos:

1. Instalación de dependencias (`bundle install`)
2. Ejecución de pruebas automatizadas (`rspec`)
3. Construcción de la imagen Docker (`docker build`)
4. (Opcional) Publicación de la imagen en Docker Hub

### Variables necesarias

- `DOCKER_REGISTRY`: Registro Docker (ej: `docker.io/usuario`)
- Credenciales Docker: deben estar configuradas en Jenkins como `dockerhub-creds`.

### Plugins necesarios

- Docker Pipeline
- GitHub Plugin
