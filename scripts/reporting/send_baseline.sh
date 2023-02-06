#!/bin/bash

# Go into reports folder
cd ~/.reports/baseline || exit

#check reports folder for file most recently created from baseline and send to google server
MOST_REC_FILEPATH=$( ls ~/.reports/baseline -t | head -n1 )

# Get the name of the most recent file without path and extension
MOST_REC_FILENAME=$( basename "$MOST_REC_FILEPATH" .csv)

# Create a zip file with this file in the current directory
# bzip2 compression reduces file size by ~ 88%
# Expected output is $MOST_REC_FILENAME.zip and the original csv file deleted
zip -jm -Z bzip2 "$MOST_REC_FILENAME" "$MOST_REC_FILEPATH" 

# if connection lost the script will exit with status 1 and output error message
if sshpass -p "$SSHPASS" scp "$MOST_REC_FILENAME.zip" edulution@130.211.93.74:/home/edulution/reports/baseline; then
	echo "${GREEN}${BOLD}Report submitted successfully!${RESET}"
else
	echo "${RED}${BOLD}Report not submitted. Please check your internet connection and try again 1>&2${RESET}"
	exit 1
fi