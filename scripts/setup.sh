#!/bin/bash

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "NAME"
  echo "	setup - Baseline setup script"
  echo
  echo "DESCRIPTION"
  echo "	Setup is a script that used to setup offline testing. "
  echo 
  echo "	Setup links npm packages required for learner assesment, Opening up port for external access,"
  echo "	get users from KOLIBRI, set up cronjob and start testing server."
  echo 
  echo "	Documentation for get users script, set up cronjob and start testing server script can be viewed "
  echo "	by using -h or --help option for the repective script."
  echo 
  echo "Example"
  echo "	./setup.sh "
  exit 1
fi

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
