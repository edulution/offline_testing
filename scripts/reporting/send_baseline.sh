#!/bin/bash

# Go into reports folder
cd ~/.reports/baseline

#check reports folder for most recent baseline report and send to google server
# if connection lost the script will exit with status 1 and output error message
if sshpass -p $SSHPASS scp `ls ~/.reports/baseline -t | head -n1` edulution@130.211.93.74:/home/edulution/reports/baseline; then
	echo "${green}${bold}Baseline submitted successfully!${bold}"
else
	echo "${red}${bold}Baseline not submitted. Please check your internet connection and try again${reset}" 1>&2
	exit 1
fi