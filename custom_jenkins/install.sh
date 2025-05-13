#!/bin/bash

# Define container name
CONTAINER_NAME="jenkins"

# Run update and install commands inside the container
docker exec -it "$CONTAINER_NAME" bash -c "
  apt update -y && \
  apt install -y python3 && \
  ln -s /usr/bin/python3 /usr/bin/python && \
  apt install -y python3-pip && \
  apt install -y python3-venv
"
