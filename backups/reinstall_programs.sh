#!/bin/bash
#
# This script restores a Debian-based system's package state from a backup.
# It adds repository keys, updates the sources list, installs dselect,
# sets package selections, and installs/upgrades packages based on those
# selections.

# Add repository keys from Repo.keys
sudo apt-key add data/Repo.keys

# Copy sources.list files to /etc/apt/
sudo cp -R data/sources.list* /etc/apt/

# Update package list from new sources
sudo apt-get update

# Install dselect package manager
sudo apt-get install dselect

# Update package list using dselect
sudo dselect update

# Set package selections from Package.list
sudo dpkg --set-selections <data/Package.list

# Install/upgrade packages based on selections
sudo apt-get dselect-upgrade -y
