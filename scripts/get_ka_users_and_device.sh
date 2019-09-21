#!/bin/bash

#colors
#=======
export red=`tput setaf 1`
export green=`tput setaf 2`
export yellow=`tput setaf 3`
export blue=`tput setaf 4`

# reset to default bash text style
export reset=`tput sgr0`

# make actual text bold
export bold=`tput bold`

# check if test responses db exists. If not, copy pristine db 
test -f $responses_database
if [ "$?" = "0" ]; then
	echo "${blue}Database already exists.Skipping...${reset}"
else
	echo "${green}Database does not exist. Creating now...${reset}"
	cp ~/.baseline_testing/public/test_responses.pristine.sqlite ~/.baseline_testing/public/test_responses.sqlite
fi


# get device name and store it in csv file
echo "extracting users and device name from kolibri"
# run R script to get users and device from kolibri
Rscript get_kolibri_users_and_device.R

if [ "$?" = "0" ]; then
	echo "${green}Done!${reset}"
else
	echo "${red}${bold}There was a problem extracting learners from kolibri${reset}"
fi
