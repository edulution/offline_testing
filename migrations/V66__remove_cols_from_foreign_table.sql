-- Remove these columns
FROM
    the FOREIGN TABLE ext.kolibriauth collection due TO error caused
    WHEN running spassignmembership ALTER FOREIGN TABLE ext.kolibriauth_collection
            DROP COLUMN IF EXISTS lft;

ALTER FOREIGN TABLE ext.kolibriauth_collection
    DROP COLUMN IF EXISTS rght;

ALTER FOREIGN TABLE ext.kolibriauth_collection
    DROP COLUMN IF EXISTS tree_id;

ALTER FOREIGN TABLE ext.kolibriauth_collection
    DROP COLUMN IF EXISTS level;

