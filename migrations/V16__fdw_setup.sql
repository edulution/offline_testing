/*create foreign data wrapper*/
CREATE EXTENSION postgres_fdw;

/*create server which links to locally hosted kolibri server*/
CREATE SERVER kolibri_server
  FOREIGN DATA WRAPPER postgres_fdw
  OPTIONS (host 'localhost',  port '5432' , dbname 'kolibri');

/*User mapping credentials not exposed in this file. replace baseline_testing and baseline_testing appropriately */
CREATE USER MAPPING FOR baseline_testing
  SERVER kolibri_server
  OPTIONS (user '<user>', password '<password>');


/*create a schema*/
CREATE SCHEMA ext;

/*import the entire schema from kolibri into the ext schema in baseline_testing*/
IMPORT FOREIGN SCHEMA public
  FROM SERVER kolibri_server
  INTO ext;