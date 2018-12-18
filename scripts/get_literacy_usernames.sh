#!/bin/bash

# get config vars
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

# check if device is online or offline
timeout 10 wget -q --spider http://google.com

if [[ $? -eq 0 ]]; then
    #statements
    echo "${green}Device is Online${reset}"
    echo "Fetching details for Literacy learners...."
    # if device is online, download file from server with literacy learners then add to db on local server
    sshpass -p $SSHPASS rsync --progress -e ssh edulution@130.211.93.74:/home/edulution/baseline/literacy_learners ~/.baseline_testing/
    
    # Add literacy users to database
    sqlite3 $responses_database <<!
.mode csv
.import $literacy_users_file users
!
    if [ "$?" = "0" ]; then
        echo "${green}Adding details for literacy learners...${reset}"
        echo "${green}${bold}Done!${reset}"
    else
        echo "${red}There was a problem fetching details for literacy learners. Please check your internet connection or try again"
        echo "Please Ignore this message if your centre does not give literacy lessons${reset}"
    fi
else
    echo "${yellow}Device is Offline"
    echo "Could not fetch details for Literacy learners"
    echo "Please Ignore this message if your centre does not give literacy lessons${reset}"
fi