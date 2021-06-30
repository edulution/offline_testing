/*Get the next course in a module based on sort order
  Args:
    sort_order integer
    module string
  Returns:
    complete row from course*/
    
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
