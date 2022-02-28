/*View to show the test scores for each test
Joined with config tables to get all details of the test, test_seq, course_family etc*/
DROP VIEW vresponsescore CASCADE;

CREATE OR REPLACE VIEW vresponsescore AS
WITH scores AS
/*CTE to calculate score for each test and join all the details from config tables*/
(
    SELECT
        responses.user_id,
        responses.response_id,
        responses.module,
        responses.course,
        c.course_family,
        responses.test,
        t.test_seq,
        responses.test_date,
        COALESCE(
            responses.q1::numeric, 0::numeric
) + COALESCE(
            responses.q2::numeric, 0::numeric
) + COALESCE(
            responses.q3::numeric, 0::numeric
) + COALESCE(
            responses.q4::numeric, 0::numeric
) + COALESCE(
            responses.q5::numeric, 0::numeric
) + COALESCE(
            responses.q6::numeric, 0::numeric
) + COALESCE(
            responses.q7::numeric, 0::numeric
) + COALESCE(
            responses.q8::numeric, 0::numeric
) + COALESCE(
            responses.q9::numeric, 0::numeric
) + COALESCE(
            responses.q10::numeric, 0::numeric
) + COALESCE(
            responses.q11::numeric, 0::numeric
) + COALESCE(
            responses.q12::numeric, 0::numeric
) + COALESCE(
            responses.q13::numeric, 0::numeric
) + COALESCE(
            responses.q14::numeric, 0::numeric
) + COALESCE(
            responses.q15::numeric, 0::numeric
) + COALESCE(
            responses.q16::numeric, 0::numeric
) + COALESCE(
            responses.q17::numeric, 0::numeric
) + COALESCE(
            responses.q18::numeric, 0::numeric
) + COALESCE(
            responses.q19::numeric, 0::numeric
) + COALESCE(
            responses.q20::numeric, 0::numeric
) + COALESCE(
            responses.q21::numeric, 0::numeric
) + COALESCE(
            responses.q22::numeric, 0::numeric
) + COALESCE(
            responses.q23::numeric, 0::numeric
) + COALESCE(
            responses.q24::numeric, 0::numeric
) + COALESCE(
            responses.q25::numeric, 0::numeric
) + COALESCE(
            responses.q26::numeric, 0::numeric
) + COALESCE(
            responses.q27::numeric, 0::numeric
) + COALESCE(
            responses.q28::numeric, 0::numeric
) + COALESCE(
            responses.q29::numeric, 0::numeric
) + COALESCE(
            responses.q30::numeric, 0::numeric
) + COALESCE(
            responses.q31::numeric, 0::numeric
) + COALESCE(
            responses.q32::numeric, 0::numeric
) + COALESCE(
            responses.q33::numeric, 0::numeric
) + COALESCE(
            responses.q34::numeric, 0::numeric
) + COALESCE(
            responses.q35::numeric, 0::numeric
) + COALESCE(
            responses.q36::numeric, 0::numeric
) + COALESCE(
            responses.q37::numeric, 0::numeric
) + COALESCE(
            responses.q38::numeric, 0::numeric
) + COALESCE(
            responses.q39::numeric, 0::numeric
) + COALESCE(
            responses.q40::numeric, 0::numeric
) + COALESCE(
            responses.q41::numeric, 0::numeric
) + COALESCE(
            responses.q42::numeric, 0::numeric
) + COALESCE(
            responses.q43::numeric, 0::numeric
) + COALESCE(
            responses.q44::numeric, 0::numeric
) + COALESCE(
            responses.q45::numeric, 0::numeric
) + COALESCE(
            responses.q46::numeric, 0::numeric
) + COALESCE(
            responses.q47::numeric, 0::numeric
) + COALESCE(
            responses.q48::numeric, 0::numeric
) + COALESCE(
            responses.q49::numeric, 0::numeric
) + COALESCE(
            responses.q50::numeric, 0::numeric
) + COALESCE(
            responses.q51::numeric, 0::numeric
) + COALESCE(
            responses.q52::numeric, 0::numeric
) + COALESCE(
            responses.q53::numeric, 0::numeric
) + COALESCE(
            responses.q54::numeric, 0::numeric
) + COALESCE(
            responses.q55::numeric, 0::numeric
) + COALESCE(
            responses.q56::numeric, 0::numeric
) + COALESCE(
            responses.q57::numeric, 0::numeric
) + COALESCE(
            responses.q58::numeric, 0::numeric
) + COALESCE(
            responses.q59::numeric, 0::numeric
) + COALESCE(
            responses.q60::numeric, 0::numeric
) + COALESCE(
            responses.q61::numeric, 0::numeric
) + COALESCE(
            responses.q62::numeric, 0::numeric
) + COALESCE(
            responses.q63::numeric, 0::numeric
) + COALESCE(
            responses.q64::numeric, 0::numeric
) + COALESCE(
            responses.q65::numeric, 0::numeric
) + COALESCE(
            responses.q66::numeric, 0::numeric
) + COALESCE(
            responses.q67::numeric, 0::numeric
) + COALESCE(
            responses.q68::numeric, 0::numeric
) + COALESCE(
            responses.q69::numeric, 0::numeric
) + COALESCE(
            responses.q70::numeric, 0::numeric
) AS score,
        t.test_type,
        t.testmaxscore,
        t.test_pass_score,
        c.sort_order,
        c.channel_id
    FROM
        responses responses
    LEFT JOIN test_marks t ON responses.test::text = t.test_id::text
        AND responses.course::text = t.course::text
        AND responses.module::text = t.module::text
    LEFT JOIN course c ON responses.course::text = c.course::text
        AND responses.module::text = c.module::text)
/*Select the releant fields from the CTE above*/
SELECT
    user_id,
    response_id,
    module,
    course,
    course_family,
    test,
    test_seq,
    test_type,
    test_date,
    score,
    testmaxscore,
    test_pass_score,
    /*Boolean field representing whether or not the test was passed*/
    CASE WHEN score >= (testmaxscore::numeric * test_pass_score) THEN
        TRUE
    ELSE
        FALSE
    END AS passed,
    sort_order,
    channel_id
FROM
    scores;

-- Placed in the same migration because it depends on vresponsescore and will get dropped everytime this migration is ran
/* Function to Get the test with the highest(numerically largest) sort_order, of type TST which a user has passed
 Args:
 user_id uuid
 module string
 Returns:
 Complete row from vresponsescore*/
CREATE OR REPLACE FUNCTION get_highest_passed_test (i_userid uuid, i_module character varying)
    RETURNS SETOF vresponsescore
    LANGUAGE 'plpgsql'
    COST 100 VOLATILE PARALLEL UNSAFE
    AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
        *
    FROM
        vresponsescore vr
    WHERE
        passed IS TRUE
        AND test_type = 'TST'
        AND vr.user_id = i_userid
        AND vr.module = i_module
        AND sort_order = (
            SELECT
                max(sort_order)
            FROM
                vresponsescore resp
            WHERE
                resp.user_id = vr.user_id
                AND resp.module = vr.module
                AND test_type = 'TST'
                AND passed IS TRUE)
    ORDER BY
        test_date
    LIMIT 1;
END;
$BODY$;

-- Function to get the tests that a learner has not passed within a module
-- Placed in the same migration because it depends on vresponsescore and will get dropped everytime this migration is ran
/*Args:
 user_id uuid
 module string
Returns:
 One row of user_id and test_marks.* for each test that a user has not passed within the supplied module */
CREATE OR REPLACE FUNCTION get_tests_not_passed (i_userid uuid, i_module varchar)
    RETURNS TABLE (
        user_id uuid,
        test_id varchar,
        test_name varchar,
        course varchar,
        module varchar,
        testmaxscore integer,
        test_pass_score numeric,
        channel_id uuid,
        test_type varchar,
        test_seq integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        *
    FROM (
        SELECT
            i_userid AS user_id) u
    CROSS JOIN (
        SELECT
            *
        FROM
            test_marks
        WHERE
            test_marks.test_seq IS NOT NULL
            AND test_marks.module = i_module) tm
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            vresponsescore v
        WHERE
            u.user_id = v.user_id
            AND tm.test_id = v.test
            AND tm.course = v.course
            AND tm.module = v.module
            AND passed = 't');
END;
$$
