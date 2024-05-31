#!/bin/bash

# Change ownership of /var/lib/docker/ to user 'metalconker'
sudo chown metalconker /var/lib/docker/

# Change directory to /var/lib/docker/
cd /var/lib/docker/

# Print message indicating completion of Docker cleanup
echo "Docker cleanup complete, volumes are preserved."

# Check if the script is being run from the correct directory
if [ "/var/lib/docker" == "$(pwd)" ]; then
    echo "Script is being run from the correct directory."
else
    echo "*******"
    echo "ERROR: Load script from cd_docker. Exiting."
    echo "*******"
    exit 0
fi

# Stop and remove containers defined in docker-compose.yml
docker compose down

# Set the path to the folder to be watched
WATCH_PATH="/usr/local/scripts/docker-scripts"

# Set the path to the destination
DEST_PATH="/var/lib/docker"

sudo cp "$WATCH_PATH"/{docker-compose.yml,.env,READ_ME_FIRST.md} "$DEST_PATH/"
sudo cp -r "$WATCH_PATH/config" "$DEST_PATH/"

# Sleep briefly to ensure copying is completed
sleep 0.2

# Start containers using docker-compose
docker compose build --pull
docker compose up --force-recreate
