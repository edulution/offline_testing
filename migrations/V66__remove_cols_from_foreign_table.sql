-- Remove these columns from the foreign table ext.kolibriauth collection due to error caused when running spassignmembership
ALTER FOREIGN TABLE ext.kolibriauth_collection
    DROP COLUMN IF EXISTS lft;

ALTER FOREIGN TABLE ext.kolibriauth_collection
    DROP COLUMN IF EXISTS rght;

ALTER FOREIGN TABLE ext.kolibriauth_collection
    DROP COLUMN IF EXISTS tree_id;

ALTER FOREIGN TABLE ext.kolibriauth_collection
    DROP COLUMN IF EXISTS level;

