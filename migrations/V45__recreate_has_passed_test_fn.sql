/*Slight change to has_passed_test to account for user not writing the test before*/
/*Was referrred to in another migration but with an older version*/
DROP FUNCTION public.has_passed_test(uuid, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION public.has_passed_test(
	i_userid uuid,
	i_test character varying,
	i_course character varying,
	i_module character varying)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
/*Array of booleans to store whether or not each test was passed*/
arr_test_bools boolean[];

/*Boolean return value*/
has_passed_test boolean;

response_row record;

BEGIN
/*Check if a row exists in responses for the inputted user_id, test course amd module*/
	IF exists
	  (SELECT 1
	   FROM responses
	   WHERE user_id = i_userid
	     AND test = i_test
	     AND course = i_course
	     AND module = i_module) THEN 
	/*Loop through the rows in responses that the user has done in the test of interest*/
		FOR response_row IN
			SELECT *
			FROM responses
			WHERE user_id = i_userid
			  AND test = i_test
			  AND course = i_course
			  AND module = i_module LOOP 
			  /*Calculate the test score*/ /*Then append the boolean of whether the test was passed or not into the array of booleans*/
			  arr_test_bools := array_append(arr_test_bools,(SELECT passed FROM calc_test_score(response_row.response_id)));

		END LOOP;

	ELSE
	/*If the condition above is not satisfied, add a false to arr_test_bools*/
		arr_test_bools := array_append(arr_test_bools,'f'::boolean);

	END IF;

	/*Check if arr_test_bools contains at least one TRUE value*/
	/*Assign the result to has_passed_test*/
	has_passed_test := arr_test_bools @> array['t'::boolean];

	/*Return the value above*/
	RETURN has_passed_test;
	
END;
$BODY$;