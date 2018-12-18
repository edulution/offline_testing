#!/bin/bash

# First time setup script
# Go into directory for baseline testing
cd ~/.baseline_testing/

# Link npm packages
npm link sqlite3
npm link csv
npm link body-parser
npm link express

#make scripts executable
chmod +x ~/.baseline_testing/scripts/reporting/baseline.sh
chmod +x ~/.baseline_testing/scripts/reporting/send_baseline.sh
chmod +x ~/.baseline_testing/scripts/setup_cronjob.sh
chmod +x ~/.baseline_testing/scripts/schema_upgrade.sh
chmod +x ~/.baseline_testing/scripts/start_users_extraction.sh
chmod +x ~/.baseline_testing/scripts/start_testing_server.sh

#set up responses db and get users from KA,IXL. Check for any schema upgrades
~/.baseline_testing/scripts/start_users_extraction.sh

#set up cron job to restart and repopulate users table on reboot
~/.baseline_testing/scripts/setup_cronjob.sh

# Stop any running forever processes and start the server
# assumes that node and forever located in /usr/local/bin
~/.baseline_testing/scripts/start_testing_server.sh
