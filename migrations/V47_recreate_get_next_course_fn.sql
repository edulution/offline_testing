-- Get next course function now includes a condition to get the max course when a user surpasses the max course
CREATE OR REPLACE FUNCTION get_next_course (i_sortorder integer, i_module character varying)
    RETURNS SETOF course
    LANGUAGE 'plpgsql'
    COST 100 VOLATILE PARALLEL UNSAFE
    AS $BODY$
DECLARE
    max_course record;
BEGIN
    -- Get the max course in the module. Store the entire record in the max_course variable
    SELECT
        *
    FROM
        get_max_course (i_module) INTO max_course;
    --If the inputted sort order is the same as the max course, return the max course
    IF (i_module = max_course.module AND i_sortorder = max_course.sort_order) THEN
        RETURN QUERY
        SELECT
            *
        FROM
            get_max_course (i_module);
    ELSE
        -- If it is not equal to the max course, then attempt to query for the next course
        RETURN QUERY
        SELECT
            *
        FROM
            course c
        WHERE
            c.sort_order::integer > i_sortorder
            AND c.module = i_module
        ORDER BY
            sort_order ASC
        LIMIT 1;
    END IF;
END;
$BODY$;

