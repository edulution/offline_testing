#!/bin/bash

#colors
#=======
export red
red=$(tput setaf 1)
export green
green=$(tput setaf) 2
export yellow
yellow=$(tput setaf) 3
export blue
blue=$(tput setaf) 4

# reset to default bash text style
export reset
reset=$(tput sgr0)

# make actual text bold
export bold
bold=$(tput bold)

# check if device is online or offline
if timeout 10 wget -q --spider http://google.com; then
    # inform the user that the device is online and attempt to fetch the details of literacy learners from the server
    echo "${green}Device is Online${reset}"
    echo "Fetching details for Literacy learners...."
    
    # if device is online, download file from server with literacy learners then add to db on local server
    if sshpass -p "$SSHPASS" rsync --progress -e ssh edulution@130.211.93.74:/home/edulution/baseline/literacy_learners ~/.baseline_testing/ > /dev/null; then
        echo "${green}Successfully fetched details for literacy learners...${reset}"
    else
        echo "${red}There was a problem fetching details for literacy learners. Please check your internet connection or try again${reset}"
    fi

    # Add literacy users to database
    if Rscript ~/.baseline_testing/scripts/insert_literacy_users_into_baseline.R "$literacy_users_file" > /dev/null; then
        echo "${green}Adding details for literacy learners...${reset}"
        echo "${green}${bold}Done!${reset}"
    else
        echo "${red}There was a problem fetching details for literacy learners. Please check your internet connection or try again${reset}"
    fi

# if device is offline, insert the most recently downloaded list
else
    # inform the user that the device is offline
    echo "${yellow}Device is Offline${reset}"
    
    # test if the most recent list exists 
    if test -f "$literacy_users_file"; then
        # if the file exists, insert it into the database
        echo "${yellow}Could not fetch latest details for Literacy learners. Inserting previously downloaded details..${reset}"
        Rscript ~/.baseline_testing/scripts/insert_literacy_users_into_baseline.R "$literacy_users_file" > /dev/null
    else
        # if no recent file exists and the device is offline. print out an error message in red
        echo "${red} Could not fetch latest details for Literacy learners and no previous list was found.."
        # inform the user to check their internet connection and try again
        echo "Please check your internet connection and try again. If the problem persists, contact support ${reset}"
    fi

fi