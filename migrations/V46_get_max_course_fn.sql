/*Function to get the max course in a module*/
CREATE OR REPLACE FUNCTION get_max_course (i_module character varying)
    RETURNS SETOF course
    LANGUAGE 'plpgsql'
    COST 100 VOLATILE PARALLEL UNSAFE
    AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
        c.*
    FROM (
        SELECT
            module,
            MAX(sort_order) AS max_sort_order
        FROM
            course
        GROUP BY
            module) AS max_course
    INNER JOIN course AS c ON c.module = max_course.module
        AND c.sort_order = max_course.max_sort_order
WHERE
    c.module = i_module
END;
$BODY$;

