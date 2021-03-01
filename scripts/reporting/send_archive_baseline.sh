#!/bin/bash

# Go into Archive_Learner folder
cd ~/Archive_Learner/baseline || exit

#check reports folder for most recent baseline report and send to google server
# if connection lost the script will exit with status 1 and output error message
# if sshpass -p "$SSHPASS" scp `ls ~/.reports/archive_learners/baseline -t | head -n1` edulution@130.211.93.74:/home/edulution/reports/archive_learners/; then
# 	echo "${GREEN}${BOLD}Baseline submitted successfully!${RESET}"
# else
# 	echo "${RED}${BOLD}Archive Learner Baseline not submitted. Please check your internet connection and try again${RESET}" 1>&2
# 	exit 1
# fi
