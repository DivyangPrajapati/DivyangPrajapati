# Docker Commands

## General Commands

### Check Docker Version

    docker --version

or

    docker -v

### Display Docker System Information

    docker info

### Docker Help

    docker help

---

## Docker Images

### Lists all downloaded images

    docker images

or 

    docker image ls

### Pull an image from a registry.

    docker pull <image_name>

### Pull specific version of the image

    docker pull <image_name>:<tag>

Example:

    docker pull hello-world:nanoserver-ltsc2025

### Remove an image

    docker rmi <image_name>

### Remove unused images

    docker image prune -a

### Build an image

    docker build -t <image-name> .

* -t, --tag => Assign image name and tag

## Docker Containers

### Create and start a new container

    docker run <image_name>

### Run Container in Detached Mode

    docker run -d <image_name>

* -d, --detach => Detached mode: run command in the background 

### Run Container in Detached Mode

    docker run -e <image_name>

* -e, --env => Set environment variables

Example:

    docker run -e MYSQL_ROOT_PASSWORD=secret-pw -d mysql

### Run Container in interactive terminal mode

    docker run -it <image_name>

* -i, --interactive => Keep STDIN open even if not attached
* -t, --tty => Allocate terminal session

Example:

    docker run -it ubuntu

    docker pull -it ubuntu bash

### Auto Remove Container After Exit

    docker run --rm -it <container_name>

* --rm => Automatically remove the container and its associated anonymous volumes when it exits

### Run Container with Port Mapping

    docker run -p 8080:80 <image_name>

* -p => Maps host port 8080 to container port 80

### Run Container with Name

    docker run --name <container_name> <image_name>

* --name => Assigns a custom name to the container

### List Running Containers

    docker ps

### List All Containers

    docker ps -a

Displays all containers including stopped ones.

### Stop a Container

    docker stop <container_id>      # Or <container_name>


### Start a Container

    docker start <container_id>     # Or <container_name>

### Remove a container

    docker rm <container_id>     # Or <container_name>

### Remove all stopped containers 

    docker container prune

## Docker Volumes

### Create a volume

    docker volume create <volume-name>

### List volumes

    docker volume ls

### Remove a volumes

    docker volume rm <volume-name>

### Remove unused volumes

    docker volume prune

## Docker Networks

### List networks

    docker network ls

### Create a network

    docker network create <network-name>

### Remove network

    docker network rm <network-name>

## Docker Compose

### Start services

    docker compose up

Starts services defined in compose.yaml

### Start services with specific file name

    docker compose -f <compose-file-name> up

* -f, --file =>  Compose configuration files

### Start in detached Mode

    docker compose up -d

### Stop services

    docker compose down

### Stop services with specific file name

    docker compose -f <compose-file-name> down

* -f, --file =>  Compose configuration files

### View running services

    docker compose ps

### View logs

    docker compose logs

### Rebuild Services

    docker compose build

Builds or rebuilds services.

## Docker Inspect & Logs

### Displays container logs

    docker logs <container_id>

### Inspect container

    docker inspect <container_id>

Returns low-level JSON information.

### View Running Processes

    docker top <container_id>

Shows processes running inside container.

### View Resource Usage

    docker stats

## Docker Exec & Debugging

### Execute Command in Running Container

    docker exec -it <container_id> bash

Example:

    docker exec -it mysql-container-id /bash/bash

    docker exec -it alpine-container-id /bin/sh

## System & Cleanup Commands

### View docker disk usage

    docker system df

### Remove unused data

    docker system prune

Removes stopped containers, dangling images, unused networks

### docker system prune

    docker system prune

Removes stopped containers, unused images, unused networks

## Registry Commands

### Login to Docker Hub

    docker login

### Push an Image

    docker push <namespace>/<repo-name>:<tag>

### Logout

    docker logout

## Quick Cleanup Commands

### Stop all containers

    docker stop $(docker ps -q)

## Remove all containers

    docker rm $(docker ps -aq)

## Remove all images

    docker rmi $(docker images -q)

## Full docker cleanup

    docker system prune -a --volumes

## Multiline Command Examples

    docker run -d \
        --name mongo \
        -p 27017:27017 \
        --network mongo-network \
        -e MONGO_INITDB_ROOT_USERNAME=admin \
        -e MONGO_INITDB_ROOT_PASSWORD=secret \
        mongo

## Docker Workflow Example

    # Pull Image
    docker pull nginx

    # Verify Image
    docker images

    # Run Container
    docker run -d --name webserver -p 8080:80 nginx

    # Check Running Containers
    docker ps

    # View Logs
    docker logs webserver

    # Enter Running Container
    docker exec -it webserver bash

    # Stop Container
    docker stop webserver

    # Start Existing Container Again
    docker start webserver

    # Restart Container
    docker restart webserver

    # Remove Container
    docker rm -f webserver

    # Remove Image
    docker rmi nginx

## Dockerfile Example

### Dockerfile 
    # Base image
    FROM node:20-alpine

    # Create app directory
    WORKDIR /app

    # Copy package files (better layer caching)
    COPY package*.json ./

    # Install dependencies
    RUN npm install

    # Copy project files
    COPY . .

    # Expose application port. (EXPOSE is documentation only. It does not open or publish any port.)
    EXPOSE 3000

    # Start application
    CMD ["npm", "start"]

### Build and run docker image
    # Build image
    docker build -t app-name .

    # Run build image
    docker run -d -p 3000:3000 app-name

## Docker Compose Example

### compose.yaml

    services:
        app:
            build: .    # Build image from local Dockerfile
            # image: node:20-alpine   # Or use existing image
            container_name: node-app
            ports:
            - "3000:3000"           # host:container

            depends_on:
                - mysql
            
            environment:
                DB_HOST: mysql
                DB_USER: root
                DB_PASSWORD: secret
                DB_NAME: mydb

            # Persistent storage
            volumes:
                - .:/app            # Maps local project folder into the container, Mainly used for development
                - /app/node_modules

    mysql:
        image: mysql:8.0
        container_name: mysql-db

        # Restart automatically after crash
        restart: always

        environment:
            MYSQL_ROOT_PASSWORD: secret
            MYSQL_DATABASE: mydb

        ports:
            - "3306:3306"

        volumes:
            - mysql_data:/var/lib/mysql

    volumes:
        mysql_data:

### Build and Start

    docker compose up --build