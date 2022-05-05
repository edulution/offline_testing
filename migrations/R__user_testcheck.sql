/*Function that checks whether or not a user is eligible to write a given test*/
/*Based on the following criteria:*/
/*Learners must only be able to write a Pre Test once and once only
Learners cannot write any test or testlet that they have passed before
Learners can write Pre Tests from different levels on the same day
 */
CREATE OR REPLACE FUNCTION user_testcheck (i_userid uuid, i_test varchar, i_course varchar, i_module varchar, i_date varchar)
    RETURNS TABLE (
        can_write_test boolean,
        output_message text)
    LANGUAGE plpgsql
    AS $$
DECLARE
    highest_test_passed RECORD;
    has_written_currtest boolean;
    has_passed_currtest boolean;
    possible_rewrite boolean;
    current_test RECORD;
    recommended_test RECORD;
    recommended_course RECORD;
    can_write_test boolean;
    output_message text;
    has_written_test_on_same_day boolean;
BEGIN
    /*Get all details of the current test and store them in the current*/
    SELECT
        *
    FROM
        test_marks
    WHERE
        test_id = i_test
        AND course = i_course
        AND module = i_module INTO current_test;

    /*Check if the user has already written the current test*/
    SELECT
        has_written_test (i_userid, i_test, i_course, i_module) INTO has_written_currtest;

    /*Check if the user has already passed the current test*/
    SELECT
        has_passed_test (i_userid, i_test, i_course, i_module) INTO has_passed_currtest;

    /*Get the highest test the user has passed*/
    SELECT
        *
    FROM
        get_highest_passed_test (i_userid, i_module) INTO highest_test_passed;

    /*Check if the user has already written the current test on that particular day*/
    SELECT
        *
    FROM
        has_written_test_on_same_day (i_userid, i_test, i_course, i_module, i_date) INTO has_written_test_on_same_day;

    /*If the user has never passed any test, recommend the course with the lowest sort order in the module*/
    IF highest_test_passed IS NULL THEN
        SELECT
            *
        FROM
            course
        WHERE
            module = i_module
            AND sort_order IS NOT NULL
        ORDER BY
            sort_order
        LIMIT 1 INTO recommended_course;
    ELSE
        SELECT
            *
        FROM
            get_next_course (highest_test_passed.sort_order, highest_test_passed.module) INTO recommended_course;
    END IF;

    /*Get the recommended_test*/
    SELECT
        *
    FROM
        get_tests_not_passed (i_userid, i_module)
    WHERE
        course = recommended_course.course
        AND test_id NOT IN (
            SELECT
                test_id
            FROM
                get_tests_already_written (i_userid, i_module)
            WHERE
                test_type = 'TST')
    ORDER BY
        test_seq
    LIMIT 1 INTO recommended_test;
    --If a learner has written (and failed) all of the tests and testlets in a course, recommend the post-test
    IF recommended_test IS NULL THEN
        SELECT
            *
        FROM
            test_marks
        WHERE
            course = recommended_course.course
            AND module = recommended_course.module
        ORDER BY
            test_seq DESC
        LIMIT 1 INTO recommended_test;
    END IF;

    /*Check if the current test is a possible rewrite relative to the recommended test*/
    SELECT
        EXISTS (
            SELECT
                *
            FROM (
                SELECT
                    *
                FROM
                    test_marks
                WHERE
                    course = recommended_test.course --recommended course
                    AND module = recommended_test.module
                    AND test_id NOT LIKE '%_pre' -- pre test cannot be rewritten
                    AND test_seq < recommended_test.test_seq) possible_rewrites -- recommended test_seq
            WHERE
                test_id = current_test.test_id
                AND course = current_test.course
                AND module = current_test.module) INTO possible_rewrite;

    /*If the user has already written the current test on that particular day*/
    IF has_written_test_on_same_day = 't' THEN
        can_write_test := 'f';
        output_message := 'This test has already been written by this user today';

        /*No other check on literacy and grade 7 tests except whether the test has been passed or not*/
    elsif (current_test.test_type = 'EPR'
            OR current_test.module = 'literacy')
            AND has_passed_currtest = 'f' THEN
            can_write_test := 't';
        output_message := 'Check completed. This test can be written';

        /*No other check on literacy and grade 7 tests except whether the test has been passed or not*/
    elsif (current_test.test_type = 'EPR'
            OR current_test.module = 'literacy')
            AND has_passed_currtest = 't' THEN
            can_write_test := 'f';
        output_message := 'This test has already been passed. Please write another test';

        /*If the user has already passed the current test, they cannot write it again*/
    elsif has_passed_currtest = 't' THEN
        can_write_test := 'f';
        output_message := 'This test has already been passed. The recommended test is: ' || recommended_test.test_name;
        -- If the current test is a pre_test and the user has written it before
        -- The user cannot write the test
    elsif current_test.test_type = 'TST'
            AND current_test.test_id LIKE '%_pre'
            AND has_written_currtest = 't' THEN
            can_write_test := 'f';
        output_message := 'A Pre-Test can only be written once. The recommended test is: ' || recommended_test.test_name;

        /*elsif possible_rewrite = 't' THEN
         can_write_test := 'f';
         output_message := 'The recommended test is: ' || recommended_test.test_name || ' but this test can be rewritten';*/
    elsif recommended_test.test_id = current_test.test_id
            AND recommended_test.course = current_test.course
            AND recommended_test.module = current_test.module THEN
            can_write_test := 't';
        output_message := 'Check completed. This is the recommended test';
    ELSE
        /*None of the conditions above are satisfied.*/
        can_write_test := 'f';
        output_message := 'This is not an appropriate test. The recommended test is: ' || recommended_test.test_name;
    END IF;

    /*Return can write test and the output_message*/
    RETURN QUERY
    SELECT
        can_write_test,
        output_message;
END;
$$
