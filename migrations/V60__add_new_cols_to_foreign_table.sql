-- Add the new columns to the kolibriauth_facilityuser foreign table after changes to Kolibri schema
ALTER FOREIGN TABLE ext.kolibriauth_facilityuser
    ADD COLUMN deleted boolean;

ALTER FOREIGN TABLE ext.kolibriauth_facilityuser
    ADD COLUMN birth_year varchar;

ALTER FOREIGN TABLE ext.kolibriauth_facilityuser
    ADD COLUMN exam_number varchar;

ALTER FOREIGN TABLE ext.kolibriauth_facilityuser
    ADD COLUMN gender varchar;