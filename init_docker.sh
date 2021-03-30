#!/usr/bin/env bash

[ -z "$SERVER_NAME" ] && { echo "ERROR: Missing \$SERVER_NAME"; exit 1; }
[ -z "$SERVER_DOMAIN" ] && { echo "ERROR: Missing \$SERVER_DOMAIN"; exit 1; }

# Create a docker context
docker context create ${SERVER_NAME} --default-stack-orchestrator swarm --description "${SERVER_NAME} @ ${SERVER_DOMAIN}" --docker host=ssh://root@${SERVER_DOMAIN}

# Initialize docker swarm
docker --context ${SERVER_NAME} swarm init --advertise-addr 127.0.0.1
