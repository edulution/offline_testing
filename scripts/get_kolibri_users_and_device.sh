#!/bin/bash

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "NAME"
  echo " 	get_kolibri_users_and_device - Get KOLIBRI users and device"
  echo
  echo "DESCRIPTION"
  echo "  	The script extracts users for offline assesment validation."
  echo "	Using the db_exists function, get_kolibri_users_and_device checks if the baseline database exists"
  echo "	and populates the users table with learners extracted from Kolibri"
  echo
  echo "Example"
  echo " 	./check_db_exists.sh "
  exit 1
fi

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
