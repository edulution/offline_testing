CREATE OR REPLACE FUNCTION get_recommended_test(i_user_id uuid, i_module varchar)
     RETURNS varchar 
     LANGUAGE plpgsql
     AS 
$$
DECLARE
recommended_test varchar;
recommended_course RECORD;
highest_test_passed RECORD;
BEGIN 
 SELECT
        *
    FROM
        get_highest_passed_test (i_user_id, i_module) INTO highest_test_passed;

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
        test_name
    FROM
        get_tests_not_passed(i_user_id, i_module)
    WHERE
        course = recommended_course.course
        and test_id not in (select test_id from get_tests_already_written(i_user_id, i_module) where test_type = 'TST')
    ORDER BY
        test_seq
    LIMIT 1 INTO recommended_test;
    --If a learner has written (and failed) all of the tests and testlets in a course, recommend the post-test
    IF recommended_test IS NULL THEN
        SELECT
            test_name
        FROM
            test_marks
        WHERE
            course = recommended_course.course
            AND module = recommended_course.module
        ORDER BY
            test_seq DESC
        LIMIT 1 INTO recommended_test;
    END IF;
	RETURN recommended_test; 
END;
$$;



