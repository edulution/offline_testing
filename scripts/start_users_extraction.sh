#!/bin/bash

# config vars used in all scripts

# directories and files
# =====================

# path to test_responses database
export baseline_testing_directory=~/.baseline_testing/

# database for test responses
export responses_database=~/.baseline_testing/public/test_responses.sqlite

# untouched db just in case
export pristine_responses_database=~/.baseline_testing/public/test_responses.pristine.sqlite

# file to find details for literacy learners on IXL
export literacy_users_file=~/.baseline_testing/literacy_learners


#colors
#=======
export black=`tput setaf 0`
export red=`tput setaf 1`
export green=`tput setaf 2`
export yellow=`tput setaf 3`
export blue=`tput setaf 4`
export magenta=`tput setaf 5`
export cyan=`tput setaf 6`
export white=`tput setaf 7`

# reset to default bash text style
export reset=`tput sgr0`

# make actual text bold
export bold=`tput bold`

# make background color on text
export bold_mode=`tput smso`

# remove background color on text
export exit_bold_mode=`tput rmso`


# get kalite users and device name
chmod +x ~/.baseline_testing/scripts/get_ka_users_and_device.sh
~/.baseline_testing/scripts/get_ka_users_and_device.sh

# get details for literacy learners
chmod +x ~/.baseline_testing/scripts/get_literacy_usernames.sh
~/.baseline_testing/scripts/get_literacy_usernames.sh

# check if any upgrades need to be done to the schema
chmod +x ~/.baseline_testing/scripts/schema_upgrade.sh
~/.baseline_testing/scripts/schema_upgrade.sh