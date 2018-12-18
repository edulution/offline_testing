#!/bin/sh
# Go into reports folder
cd ~/reports/baseline
#check reports folder for file most recently created from monthend or alldata and send to google server
sshpass -p $SSHPASS scp `ls ~/reports/baseline -t | head -n1` edulution@130.211.93.74:/home/edulution/reports/baseline
# if connection lost the script will exit with status 1 and output error message
if [ "$?" = "0" ]; then
	echo Baseline submitted successfully!
else
	echo Baseline not submitted. Please check your internet connection and try again 1>&2
	exit 1
fi