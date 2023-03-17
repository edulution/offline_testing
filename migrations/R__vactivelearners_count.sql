CREATE VIEW vactivelearners_count AS
SELECT
    CASE WHEN class_name IS NULL THEN
        'Unenrolled'
    ELSE
        class_name
    END AS class_name,
    COUNT(*) AS class_total
FROM
    users u
    LEFT JOIN ext.kolibriauth_facilityuser kf ON u.user_id = kf.id
WHERE
    kf.deleted = 'f'
GROUP BY
    class_name;

