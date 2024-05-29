#!/bin/bash

docker compose down

echo "Docker cleanup complete, volumes are preserved."

# Get the absolute path of the script being executed
script_path=$(realpath "$0")

echo $(dirname "$script_path")

# Check if the script is being run from the correct directory
if [ "/var/lib/docker" == "$(dirname "$script_path")" ]; then
    echo "Script is being run from the correct directory."
else
    echo "*******"
    echo "ERROR: Load script from cd_docker. Exiting."
    echo "*******"
    exit 0
fi

#Set the path to the folder to be watched
WATCH_PATH="/usr/local/scripts/docker"

#Set the path to the destination
DEST_PATH="/var/lib/docker"

FILE1="docker-compose.yml"
FILE2="restart_docker.sh"
FILE3=".env"
FILE4="READ_ME_FIRST.md"

FOLDER1="config"

sudo cp "$WATCH_PATH/$FILE1" "$DEST_PATH/$FILE1"
sudo cp "$WATCH_PATH/$FILE2" "$DEST_PATH/$FILE2"
sudo cp "$WATCH_PATH/$FILE3" "$DEST_PATH/$FILE3"
sudo cp "$WATCH_PATH/$FILE4" "$DEST_PATH/$FILE4"

sudo cd -r "$WATCH_PATH/$FOLDER1" "$DEST_PATH/$FOLDER1"

sleep 0.2

docker compose up
