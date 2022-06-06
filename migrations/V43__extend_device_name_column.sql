-- Extend the name column of the device table to 5 characters
ALTER TABLE device
    ALTER COLUMN "name" TYPE varchar(5);

