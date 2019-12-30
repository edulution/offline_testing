#!/bin/bash
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

# check if directories exist
DIRECTORIES=( ~/reports/baseline )
for DIRECTORY in ${DIRECTORIES[@]}; do
  if [ ! -d "$DIRECTORY" ]; then
    mkdir "$DIRECTORY"
  else
    echo "${blue}$DIRECTORY already exists. Skipping this step${reset}"
  fi
done

#pull latest changes from master branch in repo
cd ~/.baseline_testing
git reset --hard origin/kolibri > /dev/null
git pull > /dev/null

#check if database file exists before extracting reports
test -f ~/.baseline_testing/public/test_responses.sqlite
#if db file exists then extraction and submission begin. If not, will output error message to contact support
if [ "$?" = "0" ]; then
	if (echo $1 |\
    egrep '^(1[0-2]|0[0-9])[-/][0-9]{2}' > /dev/null
	); then
       echo "${green}Extracting baseline tests for month $1${reset}"
       # fetch the first argument given(the month_year) on the command line and use it as an argument to the Rscript
       Rscript ~/.baseline_testing/scripts/reporting/baseline.R "$1"
       # After Rscript executes, execute send report script
       chmod +x ~/.baseline_testing/scripts/reporting/send_baseline.sh
       ~/.baseline_testing/scripts/reporting/send_baseline.sh
   else 
       echo "${red}${bold}Please enter a valid year and month e.g 02-17${reset}"
       exit 1 
   fi
else
	echo "${red}${bold}Error. Baseline tests NOT extracted. Please contact tech support 1>&2"
	exit 1
fi