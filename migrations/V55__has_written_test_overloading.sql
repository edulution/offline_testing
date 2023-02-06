CREATE OR REPLACE FUNCTION has_written_test (i_userid uuid, i_test character varying, i_course character varying, i_module character varying, i_date character varying)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100 VOLATILE PARALLEL UNSAFE
    AS $BODY$
DECLARE
    has_written_test boolean;
BEGIN
    SELECT
        EXISTS (
            SELECT
                *
            FROM
                responses resp
            WHERE
                resp.user_id = i_userid
                AND resp.test LIKE i_test
                AND resp.course LIKE i_course
                AND resp.module LIKE i_module
                AND resp.test_date LIKE i_date) INTO has_written_test;
    RETURN has_written_test;
END;
$BODY$;

