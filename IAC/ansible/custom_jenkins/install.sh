#!/bin/bash

# Define container name
CONTAINER_NAME="jenkins"

# Run update and install commands inside the container
docker exec -it "$CONTAINER_NAME" bash -c "
  set -e && \
  apt-get update -y && \
  apt-get install -y python3 python3-pip python3-venv curl apt-transport-https ca-certificates gnupg && \
  ln -sf /usr/bin/python3 /usr/bin/python && \
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
  echo 'deb https://packages.cloud.google.com/apt cloud-sdk main' > /etc/apt/sources.list.d/google-cloud-sdk.list && \
  apt-get update -y && \
  apt-get install -y google-cloud-sdk
"