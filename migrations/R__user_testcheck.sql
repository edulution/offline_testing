/*Function that checks whether or not a user is eligible to write a given test*/
/*Based on the following criteria:*/
/*Learners must only be able to write a Pre Test once and once only
Learners cannot write any test or testlet that they have passed before
Learners can write Pre Tests from different levels on the same day
*/
CREATE OR REPLACE FUNCTION user_testcheck(
  i_userid uuid,
  i_test varchar,
  i_course varchar,
  i_module varchar
  )
  
RETURNS TABLE(
  can_write_test boolean,
  output_message text
  )
language plpgsql
AS $$
DECLARE
highest_test_passed RECORD;

has_written_currtest boolean;

current_test record;

can_write_test boolean;
output_message text;

BEGIN
  /*Get all details of the current test and store them in the current*/
  SELECT *
FROM test_marks
WHERE test_id = i_test
  AND course = i_course
  AND module = i_module INTO current_test;

  /*Check if the user has already written the current test*/
  SELECT has_written_test(i_userid,i_test, i_course, i_module) INTO has_written_currtest;

  -- If the current test is a pre_test and the user has written it before
  -- The user cannot write the test
  if current_test.test_type = 'TST' and current_test.test_id like '%_pre' and has_written_currtest = 't' then
    can_write_test := 'f';
    output_message := 'A pre-test can only be written once';

    end if;



  /*Return can write test and the output_message*/
  RETURN QUERY
    SELECT can_write_test, output_message;
END;$$
