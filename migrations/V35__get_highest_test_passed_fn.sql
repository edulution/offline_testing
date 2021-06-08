/*Get the test with the highest(numerically largest) sort_order, of type TST which a user has passed
  Args:
    user_id uuid
    module string
  Returns:
    Complete row from vresponsescore*/

CREATE OR REPLACE FUNCTION get_highest_passed_test(
	i_userid uuid,
	i_module character varying)
	RETURNS SETOF vresponsescore
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
RETURN QUERY
  SELECT *
  FROM vresponsescore vr
  WHERE passed IS TRUE
    AND test_type = 'TST'
    AND vr.user_id = i_userid
    AND vr.module = i_module
    AND sort_order =
      (SELECT max(sort_order)
       FROM vresponsescore resp
       WHERE resp.user_id = vr.user_id
         AND resp.module = vr.module
         AND passed IS TRUE)
  ORDER BY test_date LIMIT 1;
END;
$BODY$;