#!/bin/bash

# List all active (running) containers
active_containers=$(docker ps -q)

if [ -z "$active_containers" ]; then
  echo "No active containers to stop."
else
  echo "Stopping all active containers..."
  docker stop $active_containers
  echo "All active containers have been stopped."
fi
