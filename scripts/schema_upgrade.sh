#!/bin/bash

# function to get database version
get_database_version(){
	sqlite3 $1 "pragma user_version"
}

#responses_database_version=$(get_database_version $responses_database)

# check schema version of responses db and upgrade to next version
schema_upgrade(){
	# If schema is version 0
	if [[ $(get_database_version $1) == 0 ]]; then
		echo "Database schema needs to be upgraded"
		echo "Upgrading schema to version 1" 

		# schema upgrade scripts
		sqlite3 $1 < ~/.baseline_testing/sql/1218_create_test_marks.sql

		# add course column to responses table
		sqlite3 $1 "alter table responses add column course varchar"

		# upgrade version to 1
		sqlite3 $1 "pragma user_version = 1"

		# run the function again to ensure that schema upgraded
		schema_upgrade $1

	elif [[ $(get_database_version $1) == 1 ]]; then
		# add user_id column to responses
		sqlite3 $1 "alter table responses add column user_id varchar"
		
		# attempt to get user_ids for any existing responses
		# this line should be removed after first run
		# can lead to wrongly assigned user_ids
		sqlite3 $1 "update responses set user_id = (select user_id from users where users.username = responses.username)"

		# upgrade version to 2
		sqlite3 $1 "pragma user_version = 2"

		# run the function again to ensure that schema upgraded
		schema_upgrade $1

	# Do nothing if schema is up to date. Version 2 is the latest version
	elif [[ $(get_database_version $1) == 2 ]]; then
		echo "fixing error on Numeracy Alpha A test"
		sqlite3 $1 "update responses set q22=0 where test='alpha_a1' and course='alpha_a' and module='numeracy' and q22='o'"
		echo "Database schema up to date"
	fi

}

schema_upgrade $responses_database
