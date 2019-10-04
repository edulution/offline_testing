#!/bin/bash
# Function to check whether a database exists
# The kolibri database user can be used to check for other databases on the server too
function check_db_exists(){
	if psql postgresql://$KOLIBRI_DATABASE_USER:$KOLIBRI_DATABASE_PASSWORD@$KOLIBRI_DATABASE_HOST -lqt | cut -d \| -f 1 | grep -qw $1;then
	    # database exists
	    # $? is 0
	    echo "Database Exists"
	else
	    # ruh-roh
	    # $? is 1
	    echo "Database does not exist!"
	fi
}

check_db_exists $1
