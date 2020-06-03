#!/bin/bash

# First time setup script
# Go into directory for baseline testing
cd ~/.baseline_testing || exit

# Link npm packages
npm link pg > /dev/null
npm link csv > /dev/null
npm link body-parser > /dev/null
npm link express > /dev/null

#make scripts executable
chmod +x ~/.baseline_testing/scripts/reporting/baseline.sh
chmod +x ~/.baseline_testing/scripts/reporting/send_baseline.sh
chmod +x ~/.baseline_testing/scripts/setup_cronjob.sh
chmod +x ~/.baseline_testing/scripts/start_users_extraction.sh
chmod +x ~/.baseline_testing/scripts/start_testing_server.sh
chmod +x ~/.baseline_testing/scripts/get_literacy_usernames.sh
chmod +x ~/.baseline_testing/scripts/get_kolibri_users_and_device.sh

# open up port for server
sudo ufw allow 8888 > /dev/null

#set up responses db and get users from KA,IXL. Check for any schema upgrades
~/.baseline_testing/scripts/start_users_extraction.sh

#set up cron job to restart and repopulate users table on reboot
~/.baseline_testing/scripts/setup_cronjob.sh

# Stop any running forever processes and start the server
# assumes that node and forever located in /usr/local/bin
~/.baseline_testing/scripts/start_testing_server.sh
