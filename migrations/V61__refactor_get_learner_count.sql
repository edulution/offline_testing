CREATE OR REPLACE FUNCTION get_learner_count (grade character varying)
RETURNS TABLE (
    group_name character varying,
    class_name character varying,
    total_learners bigint
)
LANGUAGE SQL
AS $BODY$
    SELECT
        COALESCE(u.group_name, 'Ungrouped') AS group_name,
        u.class_name,
        COUNT(DISTINCT u.user_id) AS total_learners
    FROM
        users u
        LEFT JOIN ext.kolibriauth_facilityuser kf ON u.user_id = kf.id
    WHERE
        u.class_name = grade
        AND kf.deleted = 'f'
    GROUP BY
        u.group_name,
        u.class_name;
$BODY$;