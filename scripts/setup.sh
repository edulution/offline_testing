#!/bin/bash

# First time setup script
# Go into directory for baseline testing
cd ~/.baseline_testing/

# Link npm packages
npm link sqlite3
npm link csv
npm link body-parser
npm link express

#set up responses db and get users from KA
~/.baseline_testing/scripts/get_ka_users_and_device.sh

#set up cron job to restart amd repopulate users table on reboot
~/.baseline_testing/scripts/setup_cronjob.sh

# Stop any running forever processes and start the server
# assumes that node and forever located in /usr/local/bin
~/.baseline_testing/scripts/start_testing_server.sh
