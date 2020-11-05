#!/bin/bash

# config vars used in all scripts

# directories and files
# =====================

# path to test_responses database
export baseline_testing_directory=~/.baseline_testing/

# file to find details for literacy learners on IXL
export literacy_users_file=~/.baseline_testing/literacy_learners

# get kolibri users and device name
~/.baseline_testing/scripts/get_kolibri_users_and_device.sh

# check if a centre is a literacy centre before fetching details for literacy learners
if [[ "$IS_LITERACY_CENTRE" == "TRUE" ]]; then
	chmod +x ~/.baseline_testing/scripts/get_literacy_usernames.sh
	~/.baseline_testing/scripts/get_literacy_usernames.sh
fi

# check if any upgrades need to be done to the schema
# chmod +x ~/.baseline_testing/scripts/schema_upgrade.sh
# ~/.baseline_testing/scripts/schema_upgrade.sh