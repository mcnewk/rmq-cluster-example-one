#!/bin/bash

set -e

# Start RMQ from entry point to ensure environment variables passed will be honored
/usr/local/bin/docker-entrypoint.sh rabbitmq-server -detached

# Do the cluster dance
rabbitmqctl stop_app
sleep 2s
rabbitmqctl join_cluster rabbit@rabbit1

rabbitmqctl stop

# Wait a while for the app to really stop
sleep 5s

# Start it
rabbitmq-server
