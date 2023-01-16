#!/bin/bash

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "NAME"
  echo "    start_testing_server - Start testing server"
  echo
  echo "DESCRIPTION"
  echo "    Using Forever, start_testing_server creates a Node.js script continuously runs in the background on the server."
  echo "	Start testing server, starts and stops the main file in the application with forever" 
  echo
  echo "Example"
  echo "    ./check_db_exists.sh "
  exit 1
fi

# Restart testing server

# set vars for forever and node
forever_path=/usr/local/bin/forever
node_path=/usr/local/bin/node

# stop all forever nodes
$forever_path -c $node_path stopall > /dev/null


# Change to the baseline directory
cd ~/.baseline_testing || exit

# start the main file in the application with forever
$forever_path start -c $node_path index.js > /dev/null

# show the first output of the logs
# $forever_path -c $node_path logs 0 > /dev/null
