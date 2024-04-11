-- Add the new columns to the kolibriauth_facilityuser foreign table after changes to Kolibri schema
ALTER FOREIGN TABLE ext.kolibriauth_facilityuser
    ADD COLUMN IF NOT EXISTS deleted boolean;

ALTER FOREIGN TABLE ext.kolibriauth_facilityuser
    ADD COLUMN IF NOT EXISTS birth_year varchar;

ALTER FOREIGN TABLE ext.kolibriauth_facilityuser
    ADD COLUMN IF NOT EXISTS exam_number varchar;

ALTER FOREIGN TABLE ext.kolibriauth_facilityuser
    ADD COLUMN IF NOT EXISTS gender varchar;

