-- Script to disable test recommendations
-- Run this directly on your database
/*Function that checks whether or not a user is eligible to write a given test*/
/*Based on the following criteria:*/
/*Learners must only be able to write a Pre Test once and once only
 Learners cannot write any test or testlet that they have passed before
 Learners can write Pre Tests from different levels on the same day
 RECOMMENDATION FEATURE DISABLED - Any test can be written as long as basic criteria are met (this is just for skills hub trainee assessments)
 */
CREATE OR REPLACE FUNCTION user_testcheck (
        i_userid uuid,
        i_test varchar,
        i_course varchar,
        i_module varchar,
        i_date varchar
    ) RETURNS TABLE (
        can_write_test boolean,
        output_message text
    ) LANGUAGE plpgsql AS $$
DECLARE has_written_currtest boolean;
has_passed_currtest boolean;
current_test RECORD;
can_write_test boolean;
output_message text;
has_written_test_on_same_day boolean;
BEGIN
/*Get all details of the current test and store them in the current*/
SELECT *
FROM test_marks
WHERE test_id = i_test
    AND course = i_course
    AND module = i_module INTO current_test;
/*Check if the user has already written the current test*/
SELECT has_written_test (i_userid, i_test, i_course, i_module) INTO has_written_currtest;
/*Check if the user has already passed the current test*/
SELECT has_passed_test (i_userid, i_test, i_course, i_module) INTO has_passed_currtest;
/*Check if the user has already written the current test on that particular day*/
SELECT *
FROM has_written_test (i_userid, i_test, i_course, i_module, i_date) INTO has_written_test_on_same_day;
/*If the user has already written the current test on that particular day*/
IF has_written_test_on_same_day = 't' THEN can_write_test := 'f';
output_message := 'This test has already been written by this user today';
/*No other check on literacy and grade 7 tests except whether the test has been passed or not*/
elsif (
    current_test.test_type = 'EPR'
    OR current_test.module = 'literacy'
)
AND has_passed_currtest = 'f' THEN can_write_test := 't';
output_message := 'Check completed. This test can be written';
/*No other check on literacy and grade 7 tests except whether the test has been passed or not*/
elsif (
    current_test.test_type = 'EPR'
    OR current_test.module = 'literacy'
)
AND has_passed_currtest = 't' THEN can_write_test := 'f';
output_message := 'This test has already been passed. Please write another test';
/*If the user has already passed the current test, they cannot write it again*/
elsif has_passed_currtest = 't' THEN can_write_test := 'f';
output_message := 'This test has already been passed. Please select another test';
-- If the current test is a pre_test and the user has written it before
-- The user cannot write the test
elsif current_test.test_type = 'TST'
AND current_test.test_id LIKE '%_pre'
AND has_written_currtest = 't' THEN can_write_test := 'f';
output_message := 'A Pre-Test can only be written once. Please select another test';
ELSE
/*Test recommendation disabled - allow any test that meets basic criteria*/
can_write_test := 't';
output_message := 'Check completed. This test can be written';
END IF;
/*Return can write test and the output_message*/
RETURN QUERY
SELECT can_write_test,
    output_message;
END;
$$;