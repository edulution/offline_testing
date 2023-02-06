-- View to get count of classroom memberships for each user

CREATE OR REPLACE VIEW user_membership_count AS
SELECT
    user_id,
    username,
    count(user_id) AS num_classes
FROM (
    SELECT
        user_id,
        username,
        name AS collection_name,
        kind
    FROM
        ext.kolibriauth_facilityuser u
    LEFT JOIN ext.kolibriauth_membership m
    LEFT JOIN ext.kolibriauth_collection c ON m.collection_id = c.id ON u.id = m.user_id) s
WHERE
    kind = 'classroom'
GROUP BY
    user_id,
    username;

