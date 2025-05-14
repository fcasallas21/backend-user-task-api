# Backend User Task API

API RESTful + GraphQL para gestión de usuarios y tareas, desarrollada en Ruby on Rails. Incluye pruebas automatizadas, autenticacion JWT(Ggraphql), contenedores Docker, integración continua (Jenkins) y buenas prácticas de desarrollo.

---

## Requisitos

- Docker y Docker Compose
- Ruby 3.1.2 (dentro del contenedor)
- PostgreSQL (se levanta con Docker)
- Bundler y Rails (se instalan en el contenedor)

---

## Levantar el proyecto con Docker

```bash
# Construir las imágenes, no es necesario el uso de  "-" para ejecucion de comandos docker solo lo siguiente:
docker compose build

##Correr migraciones
docker compose run --rm backend-app bundle exec rails db:migrate

# INstalacion y/o actualizacion de Gemas
docker compose run --rm backend-app bundle install

# Levantar el entorno segun punto 5 para servicio y bd
docker compose up
```

La aplicación estará disponible en: `http://localhost:3000`

---

## Ejecutar pruebas

```bash
# Ejecutar pruebas RSpec
docker compose run --rm -e RAILS_ENV=test backend-app bundle exec rspec
```

---

## Arquitectura

- **Ruby on Rails**: Backend REST/GraphQL
- **PostgreSQL**: Base de datos relacional
- **Docker**: Contenerización del entorno
- **RSpec**: Pruebas automatizadas
- **JWT**: Autenticazion graphql
- **Jenkins**: Pipeline CI (ver más abajo)

### Estructura Docker

```yaml
version: "3.8"

services:
  postgres:
    image: postgres:13
    environment:
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-1234}
      POSTGRES_USER: ${POSTGRES_USER:-postgres}
      POSTGRES_DB: ${POSTGRES_DB:-backend_challenge_development}
    volumes:
      - pg_data:/var/lib/postgresql/data
    networks:
      - backend_net

  backend-app:
    build:
      context: .
      dockerfile: Dockerfile
      args:
        RAILS_ENV: development
    environment:
      POSTGRES_HOST: postgres
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-1234}
      POSTGRES_USER: ${POSTGRES_USER:-postgres}
      POSTGRES_DB: ${POSTGRES_DB:-backend_challenge_development}
      RAILS_ENV: development
    ports:
      - "3000:3000"
    volumes:
      - .:/app
    depends_on:
      - postgres
    networks:
      - backend_net
    tty: true
    stdin_open: true

volumes:
  pg_data:

networks:
  backend_net:
    driver: bridge
```

---

## Integración Continua con Jenkins

Este proyecto podria ser automatizado con **Jenkins** usando el siguiente `Jenkinsfile`.

### Jenkinsfile

```groovy
pipeline {
  agent any

  environment {
    IMAGE_NAME = 'tu_usuario/backend-user-task-api'
    DOCKERHUB_CREDENTIALS = 'dockerhub-credentials-id'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Run Tests') {
      steps {
        sh 'docker-compose run --rm backend-app bundle exec rspec'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $IMAGE_NAME .'
      }
    }

    stage('Push to DockerHub') {
      when {
        expression { return params.PUSH_IMAGE == true }
      }
      steps {
        withCredentials([usernamePassword(credentialsId: env.DOCKERHUB_CREDENTIALS, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker push $IMAGE_NAME
          '''
        }
      }
    }
  }

  parameters {
    booleanParam(name: 'PUSH_IMAGE', defaultValue: false, description: '¿Hacer push de la imagen a DockerHub?')
  }
}
```

### Configuración en Jenkins

1. Crear un nuevo proyecto **Pipeline**
2. Usar "Pipeline script from SCM" y apuntar al repositorio
3. Agregar credenciales de DockerHub en Jenkins (`dockerhub-credentials-id`)
4. Ejecutar el pipeline

---

## Documentación de API

Puedes usar Insomnia, Postman o GraphQL Playground para consumir los endpoints.

- REST: `http://localhost:3000/api/v1/users`, `tasks`, etc.
#Obtener listado de tareas/usuarios
1.  GET `http://localhost:3000/api/v1/tasks` 
#Obtener listado de tarea/usuario especifico
2. GET `http://localhost:3000/api/v1/tasks/:id`
#crear tarea(POST), Actualiza tarea(PUT)
3.  POST `http://localhost:3000/api/v1/tasks`
Body (JSON):
{
  "task": {
    "title": "Nueva tarea",
    "description": "Detalles de la tarea",
    "status": "pending",
    "due_date": "2025-05-20",
    "user_id": 1
  }
}

#Eliminar tarea
4. DELETE http://localhost:3000/api/v1/tasks


- GraphQL: `http://localhost:3000/graphql`

### Ejemplo de consulta GraphQL

```graphql
{
  users {
    id
    email
    tasks {
      title
      status
    }
  }
}
```

---

## Buenas prácticas implementadas

- Indexación de columnas (`email`, `user_id`, `status`)
- Paginación con `will_paginate`
- Separación lógica en controladores y servicios
- Código limpio y modular
- Integración CI con pruebas y dockerización

---

## Preparado por:

Fabian – [fabian.dev](fcasallas21@gmail.com)
