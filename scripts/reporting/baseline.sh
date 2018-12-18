#!/bin/bash

# check if directories exist
DIRECTORIES=( ~/reports/baseline )
for DIRECTORY in ${DIRECTORIES[@]}; do
  if [ ! -d "$DIRECTORY" ]; then
    mkdir "$DIRECTORY"
  else
    echo "$DIRECTORY already exists. Skipping this step"
  fi
done

#pull latest changes from master branch in repo
cd ~/.baseline_testing
git reset --hard origin/master > /dev/null
git pull > /dev/null

#check if database file exists before extracting reports
test -f ~/.baseline_testing/public/test_responses.sqlite
#if db file exists then extraction and submission begin. If not, will output error message to contact support
if [ "$?" = "0" ]; then
	if (echo $1 |\
    egrep '^(1[0-2]|0[0-9])[-/][0-9]{2}' > /dev/null
	); then
       echo "Extracting baseline tests for month $1"
       # fetch the first argument given(the month_year) on the command line and use it as an argument to the Rscript
       Rscript ~/.baseline_testing/scripts/reporting/baseline.R "$1"
       # After Rscript executes, execute send report script
       ~/.baseline_testing/scripts/reporting/send_baseline.sh
   else 
       echo Please enter a valid year and month e.g 02-17
       exit 1 
   fi
else
	echo Error. Baseline tests NOT extracted. Please contact tech support 1>&2
	exit 1
fi