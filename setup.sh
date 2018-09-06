#!/bin/bash

# First time setup script

#set up responses db and get users from KA
~/.baseline_testing/get_users_and_device.sh

#set up cron job to restart amd repopulate users table on reboot
~/.baseline_testing/setup_cronjob.sh