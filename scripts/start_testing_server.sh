#!/bin/bash

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

# call a stored procedure to delete duplicate responses
PGPASSWORD=$BASELINE_DATABASE_PASSWORD psql -h "$BASELINE_DATABASE_HOST" -U "$BASELINE_DATABASE_USER" -d "$BASELINE_DATABASE_NAME" -c "call delete_duplicate_responses();"
