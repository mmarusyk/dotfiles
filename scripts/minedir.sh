#!/bin/bash

path=$1

if [[ -n "$path" ]]; then
  nohup mine "$1" &
else
  echo "Path error"
fi
