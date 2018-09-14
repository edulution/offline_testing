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
~/.baseline_testing/get_users_and_device.sh

#set up cron job to restart amd repopulate users table on reboot
~/.baseline_testing/setup_cronjob.sh
