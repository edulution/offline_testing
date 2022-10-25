#!/bin/bash

# source helper function to check if database exists
# shellcheck source=/dev/null
source ~/.baseline_testing/scripts/check_db_exists.sh

# use db_exists helper function to check if the baseline database exists
if db_exists "$BASELINE_DATABASE_NAME" ; then
	# Let the user know that the database already exists and skip
	echo "${BLUE}Database already exists.Skipping...${RESET}"
else
	echo "${RED}Baseline Database does not exist. Please contact support...${RESET}"
	exit 1
fi

# get device name and store it in csv file
echo "Extracting users and device name from kolibri"
# run R script to get users and device name from kolibri

if Rscript ~/.baseline_testing/scripts/get_kolibri_users_and_device.R > /dev/null; then
	echo "${GREEN}Done!${RESET}"
else
	echo "${RED}${BOLD}There was a problem extracting learners from Kolibri${RESET}"
fi
