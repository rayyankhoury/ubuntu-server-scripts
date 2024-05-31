#!/bin/bash
#
# This script creates a backup of the current package selections,
# sources list, and repository keys on a Debian-based system.
# The backup files can be used to restore the system's state in the future.

# Save list of installed packages to data/Package.list
dpkg --get-selections >data/Package.list

# Copy sources.list files to data directory
sudo cp -R /etc/apt/sources.list* data

# Export all repository keys to data/Repo.keys
sudo apt-key exportall >data/Repo.keys
