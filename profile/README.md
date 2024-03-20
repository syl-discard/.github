# Discard, a messaging platform

> :warning: **Discard is in no way affiliated with Discord!** This project is non-profit, open-source, and is created to learn more about enterprise architecture and messaging in general.

The original social media messaging Discord is in discord. Users are not happy about the way Discord is managing its business and their monetization policies in particular. This is why Discard is now in the making. Discard Inc., a fictional company, is a start-up company that is looking to exploit the gap in the market Discord made by its malpractice. Discard will be similar to Discord, in that users can create their account, create `servers', and talk to other users in the server they are both in.

The focus of the project is to learn more about enterprise development, and the scaling and maintainability of an enterprise platform to millions of users. The focus does not lay of making the project feature-complete.

## Requirements
This project is meant to be ran together. You will need Docker and Docker Compose installed. For more information, see [here](https://docs.docker.com/engine/install/).

## Setup /w Docker Compose

This project is best ran with Docker Compose. First, you will need to create a folder, for example `discard`. Move into this folder, and clone each repository from this organization:

```sh
mkdir discard && cd discard/ && touch docker-compose.yml && \
git clone git@github.com:syl-discard/frontend.git && \
git clone git@github.com:syl-discard/user-service.git && \
git clone git@github.com:syl-discard/message-service.git
```

Your folder structure, with `discard` as the root, should be like this:

```
.
└── discard
     ├── frontend
     ├── user-service
     ├── message-service
     └── docker-compose.yml
```

Open the `docker-compose.yml` file and paste the following into it:

```yml
version: "3"

# This compose file should be in the root of the project, with each 
# repository of the organization in a separate folder.

name: discard
services:

# FRONTEND
  frontend:
    container_name: frontend
    image: frontend
    build:
      context: ./frontend/
      dockerfile: Dockerfile
    user: "node"
    environment:
      - NODE_ENV=development
      - ORIGIN=http://localhost:6969
    # env_file:
    #   - .env
    restart: unless-stopped
    ports: 
      - "6969:3000"
    networks:
      - frontend-user
    depends_on:
      - user-service
      - message-service
      - rabbitmq

# USER-SERVICE
  user-service:
    container_name: user-service
    image: user-service
    build:
      context: ./user-service/
      dockerfile: Dockerfile
    # ports:
    #   - "6970:8080"
    networks:
      - frontend-user
      - user-rabbitmq
    depends_on:
      - rabbitmq
    restart: unless-stopped

# MESSAGE-SERVICE
  message-service:
    container_name: message-service
    image: message-service
    build:
      context: ./message-service/
      dockerfile: Dockerfile
    # ports:
    #   - "6971:8080"
    networks:
      - frontend-user
      - message-rabbitmq
    depends_on:
      - rabbitmq
    restart: unless-stopped

# MESSAGE BROKER
  rabbitmq:
    hostname: rabbitmq
    image: rabbitmq:3.13-management-alpine
    container_name: rabbitmq
    ports:
      # - 5672:5672
      - 15672:15672 # management plugin
    volumes:
      - ~/.docker-conf/rabbitmq/data/:/var/lib/rabbitmq/
      - ~/.docker-conf/rabbitmq/log/:/var/log/rabbitmq
    networks:
      - user-rabbitmq
      - message-rabbitmq
    healthcheck:
        test: [ "CMD", "nc", "-z", "localhost", "5672" ]
        interval: 30s
        timeout: 10s
        retries: 5

networks:
  frontend-user:
  user-rabbitmq:
  message-rabbitmq:
```

You can then run `docker compose build && docker compose`.
