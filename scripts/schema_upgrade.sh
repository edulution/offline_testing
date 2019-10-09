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
		# insert config for grade 7 revision into the test marks table
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test1','Grade 7 - Average (mean)','grade7_revision','numeracy',30);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test2','Grade 7 - Proportions and Ratios','grade7_revision','numeracy',35);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test3','Grade 7 - Number Bases','grade7_revision','numeracy',30);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test4','Grade 7 - Profit and Loss & Notation','grade7_revision','numeracy',30);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test5','Grade 7 - Money and Percentage','grade7_revision','numeracy',30);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test6','Grade 7 - Notation & Place Values','grade7_revision','numeracy',35);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test7','Grade 7 - Equation, Factors, Negative Numbers','grade7_revision','numeracy',30);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test8','Grade 7 - Area, Perimeter, Symmetry and Volume','grade7_revision','numeracy',30);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test9','Grade 7 - Notation, Length and Shapes','grade7_revision','numeracy',30);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test10','Grade 7 - Sets and Speed ','grade7_revision','numeracy',30);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test11','Grade 7 - Word Problems: Notations','grade7_revision','numeracy',30);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test12','Grade 7 - Bases, Roman Numerals and Graphs','grade7_revision','numeracy',30);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test13','Grade 7 - Fractions','grade7_revision','numeracy',30);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_test14','Grade 7 - Decimals','grade7_revision','numeracy',30);"

		# config for grade 7 mock tests
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_mock1','Grade 7 - Mock 1','grade7_revision','numeracy',60);"
		sqlite3 $1 "insert or ignore into test_marks(test_id,test_name,course,module,testmaxscore) values('grade7_mock2','Grade 7 - Mock 2','grade7_revision','numeracy',60);"

		#fix tests with wrong topic
		echo "Fixing config bug on tests with wrong topic"
		sqlite3 $1 "update responses set course = 'grade7_revision' where course = 'grade_7_revision'"

		echo "Fixing config bug on grade 7 mock tests with the wrong course"
		sqlite3 $1 "update responses set course = 'grade7_revision' where course = 'grade7_mock1'"
		sqlite3 $1 "update responses set course = 'grade7_revision' where course = 'grade7_mock2'"
		
		# Bump schema version to 3
		sqlite3 $1 "pragma user_version = 3"
		echo "Database schema up to date"

	elif [[ $(get_database_version $1) == 3 ]]; then
		echo "Add columns for Sex, Grade and Exam number"
		sqlite3 $1 "alter table responses add column sex varchar(1) check (sex == 'M' or sex == 'F');"
		sqlite3 $1 "alter table responses add column grade varchar(3);"
		sqlite3 $1 "alter table responses add column gr7_exam_number varchar(12);"

		sqlite3 $1 "pragma user_version = 4"
		# echo Run the function again in order to reach the bottom of the loop
		schema_upgrade $1

	elif [[ $(get_database_version $1) == 4 ]]; then
		echo "Database schema up to date"

	fi

}

schema_upgrade $responses_database
