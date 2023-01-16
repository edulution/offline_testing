#!/bin/bash

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "NAME"
  echo "    check_db_exists - Check databases exit"
  echo
  echo "DESCRIPTION"
  echo "    Using the Kolibri database user, the script checks if the Baseline database exists"
  echo 
  echo "Example"
  echo "    ./check_db_exists.sh "
  exit 1
fi

# Function to check whether a database exists
# The kolibri database user can be used to check for other databases on the server too
function db_exists() {
  PGPASSWORD=$BASELINE_DATABASE_PASSWORD psql -h "$BASELINE_DATABASE_HOST" -U "$BASELINE_DATABASE_USER" -lqt | cut -d \| -f 1 | grep -wq "$1"
}
