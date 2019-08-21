#!/bin/bash

# check if cronjob exists for startup_script and add it if not
# search for cronjob which matches @reboot ~/.baseline_testing/startup_script 
if (crontab -l | grep -q '@reboot ~/.baseline_testing/scripts/startup_script'); then
	#skip if already exists
	echo 'Cronjob already exists. Skipping ....'
else
	#add entry if doesnt exist
	echo 'Cronjob does not exist. Creating now'
	(crontab -l 2>/dev/null; echo "@reboot ~/.baseline_testing/scripts/startup_script") | crontab -
fi
