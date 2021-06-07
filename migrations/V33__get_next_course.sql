-- Create get_next course function
-- Get the next course given sort order and module

CREATE OR REPLACE FUNCTION get_next_course(
	i_sortorder integer,
	i_module character varying)
	RETURNS SETOF course
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
RETURN QUERY
SELECT *
FROM course c
WHERE c.sort_order::integer > i_sortorder
  AND c.module = i_module
ORDER BY sort_order ASC LIMIT 1;
END;
$BODY$;
