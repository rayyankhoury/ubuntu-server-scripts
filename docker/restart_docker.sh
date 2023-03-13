#!/bin/bash

docker compose down

#Set the path to the folder to be watched
WATCH_PATH="/usr/local/scripts/docker"

#Set the path to the destination
DEST_PATH="/var/lib/"

sudo cp -r "$WATCH_PATH" "$DEST_PATH"

sleep 0.2

docker compose up
