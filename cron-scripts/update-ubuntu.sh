#!/bin/bash

# Update the package list
sudo apt update

# Upgrade the installed packages
sudo apt upgrade -y

# Autoremove unnecessary packages
sudo apt autoremove -y

# Clean up the local repository of retrieved package files
sudo apt clean

# Log the date and time of the update
echo "Update completed on: $(date)" | sudo tee -a /var/log/update_ubuntu.log
