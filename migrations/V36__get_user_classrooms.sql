CREATE OR REPLACE FUNCTION get_user_classrooms(
	i_userid uuid)
	RETURNS SETOF ext.kolibriauth_collection
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
RETURN QUERY
SELECT c.*
FROM ext.kolibriauth_membership m
LEFT JOIN ext.kolibriauth_collection c ON m.collection_id = c.id
LEFT JOIN ext.kolibriauth_facilityuser u ON m.user_id = u.id
WHERE kind = 'classroom'
  AND m.user_id = i_userid
  AND c.parent_id = u.facility_id;
END;
$BODY$;
