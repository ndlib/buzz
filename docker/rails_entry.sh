#!/bin/bash

if ! docker/wait-for-it.sh -t 120 ${DB_HOSTNAME}:5432; then exit 1; fi

# Runs nginx + puma services
service nginx start
bundle exec puma -b "unix://${APP_HOME}/shared/sockets/puma.sock"
