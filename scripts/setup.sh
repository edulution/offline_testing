#!/bin/bash

# First time setup script

# Go into directory for baseline testing
cd ~/.baseline_testing || exit

# Link npm packages
sudo npm link pg > /dev/null
sudo npm link csv > /dev/null
sudo npm link body-parser > /dev/null
sudo npm link express > /dev/null
sudo npm link cors > /dev/null

# open up port for server
echo "Opening up port for external access"
sudo ufw allow 8888

# Get users from Kolibri and IXL (If centre gives literacy lessons)
~/.baseline_testing/scripts/start_users_extraction.sh

# Set up cronjob to restart and repopulate users table on reboot
~/.baseline_testing/scripts/setup_cronjob.sh

# Stop all running forever processes and restart the server
~/.baseline_testing/scripts/start_testing_server.sh
