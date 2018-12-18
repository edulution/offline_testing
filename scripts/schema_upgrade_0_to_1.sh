#!/bin/bash

# update schema version 0 to 1

database=$1

upgrade_schema_0_to_1(){
	# create test marks table
	sqlite3 $1 < ~/.baseline_testing/sql/1218_create_test_marks.sql

	# add course column to responses table
	sqlite3 $1 "alter table responses add column course varchar"

	sqlite3 $1 "pragma user_version = 1"
}





