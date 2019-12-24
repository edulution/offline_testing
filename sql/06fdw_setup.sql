/*create foreign data wrapper*/
CREATE EXTENSION postgres_fdw;

/*create server which links to locally hosted kolibri server*/
CREATE SERVER kolibri_server
  FOREIGN DATA WRAPPER postgres_fdw
  OPTIONS (host 'localhost',  port '5432' , dbname 'kolibri');

/*User mapping credentials not exposed in this file. replace <user> and <password> appropriately */
CREATE USER MAPPING FOR CURRENT_USER
  SERVER kolibri_server
  OPTIONS (user '<user>', password '<user>');


/*create a schema*/
CREATE SCHEMA ext;

/*import the entire schema from kolibri into the ext schema in baseline_testing*/
IMPORT FOREIGN SCHEMA public
  FROM SERVER kolibri_server
  INTO ext;