#!/bin/bash
# Function to check whether a database exists
# The kolibri database user can be used to check for other databases on the server too
#!/bin/bash
function db_exists() {
  PGPASSWORD=$BASELINE_DATABASE_PASSWORD psql -h "$BASELINE_DATABASE_HOST" -U "$BASELINE_DATABASE_USER" -lqt | cut -d \| -f 1 | grep -wq "$1"
}
