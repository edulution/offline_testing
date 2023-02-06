#!/bin/bash

# check if device is online or offline
if timeout 10 wget -q --spider http://google.com; then
    # inform the user that the device is online and attempt to fetch the details of literacy learners from the server
    echo "${GREEN}Device is Online${RESET}"
    echo "Fetching details for Literacy learners...."
    
    # if device is online, download file from server with literacy learners then add to db on local server
    if sshpass -p "$SSHPASS" rsync --progress -e ssh edulution@130.211.93.74:/home/edulution/baseline/literacy_learners ~/.baseline_testing/ > /dev/null; then
        echo "${GREEN}Successfully fetched details for literacy learners...${RESET}"
    else
        echo "${RED}There was a problem fetching details for literacy learners. Please check your internet connection or try again${RESET}"
    fi

    # Add literacy users to database
    if Rscript ~/.baseline_testing/scripts/insert_literacy_users_into_baseline.R "$literacy_users_file" > /dev/null; then
        echo "${GREEN}Adding details for literacy learners...${RESET}"
        echo "${GREEN}${BOLD}Done!${RESET}"
    else
        echo "${RED}There was a problem fetching details for literacy learners. Please check your internet connection or try again${RESET}"
    fi

# if device is offline, insert the most recently downloaded list
else
    # inform the user that the device is offline
    echo "${YELLOW}Device is Offline${RESET}"
    
    # test if the most recent list exists 
    if test -f "$literacy_users_file"; then
        # if the file exists, insert it into the database
        echo "${YELLOW}Could not fetch latest details for Literacy learners. Inserting previously downloaded details..${RESET}"
        Rscript ~/.baseline_testing/scripts/insert_literacy_users_into_baseline.R "$literacy_users_file" > /dev/null
    else
        # if no recent file exists and the device is offline. print out an error message in red
        echo "${RED} Could not fetch latest details for Literacy learners and no previous list was found..${RESET}"
        # inform the user to check their internet connection and try again
        echo "${RED}Please check your internet connection and try again. If the problem persists, contact support ${RESET}"
    fi

fi