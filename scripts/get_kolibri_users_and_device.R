# suppress warning messages
options(warn = -1)

# data manipulation libraries
suppressMessages(library(tidyr))
suppressMessages(library(plyr))
suppressMessages(library(dplyr))
suppressMessages(library(dbplyr))
suppressMessages(library(dbhelpers))

# load new packages for kolibri data extraction
suppressMessages(library(stringr))


# load postgresql library and dependency
suppressMessages(library(DBI))
suppressMessages(library(pool))
suppressMessages(library(RPostgres))


# Extraction from Kolibri database ---------------------------------------------

# connect to Kolibri database
pg <- RPostgres::Postgres()
# get database credentials from environment variables
db_name <- Sys.getenv("KOLIBRI_DATABASE_NAME")
db_host <- Sys.getenv("KOLIBRI_DATABASE_HOST")
db_user <- Sys.getenv("KOLIBRI_DATABASE_USER")
db_passwd <- Sys.getenv("KOLIBRI_DATABASE_PASSWORD")
db_port <- Sys.getenv("KOLIBRI_DATABASE_PORT")

kolibri_conn <- dbPool(
  pg,
  dbname = db_name,
  host = db_host,
  port = db_port,
  user = db_user,
  password = db_passwd
)

# get facilityysers
facilityusers <- kolibri_conn %>%
  tbl("kolibriauth_facilityuser") %>%
  collect()

# get collections
collections <- kolibri_conn %>%
  tbl("kolibriauth_collection") %>%
  collect()

# get memberships
memberships <- kolibri_conn %>%
  tbl("kolibriauth_membership") %>%
  collect()

# get roles
roles <- kolibri_conn %>%
  tbl("kolibriauth_role") %>%
  collect()


# get the default facility id
# will be used to get the device name(facility name)
default_facility_id <- kolibri_conn %>%
  tbl("device_devicesettings") %>%
  pull(default_facility_id)

# close the connection
poolClose(kolibri_conn)


# Processing --------------------------------------------------------------

# Get only the device name from the first 5 letters of the facility name
facility_name <- collections %>%
  filter(id == default_facility_id) %>%
  # Get only the first 5 characters of the name
  mutate(name = str_sub(name, 1, 5)) %>%
  # Select only the name column
  select(name)

# join collections to memberships. (used for getting user groups)
memberships <- memberships %>%
  left_join(
    collections,
    by = c("collection_id" = "id")
  )

# get dataframe containing learners and groups they belong to
learners_and_groups <- memberships %>%
  # filter out memberships of type learnergroup
  filter(kind == "learnergroup") %>%
  group_by(user_id) %>%
  # If a learner belongs to multiple classes, separate them with commas
  mutate(name = paste(name, collapse = ",")) %>%
  ungroup() %>%
  # Get only the first row if there are multiple rows for the same learner
  distinct(user_id, .keep_all = TRUE) %>%
  select("group_name" = name, user_id)


# get a data frame containing learners and the classes they belong to
learners_and_grades <- memberships %>%
  # filter out memberships of type learnergroup
  filter(kind == "classroom") %>%
  group_by(user_id) %>%
  # If a learner belongs to multiple classes, separate them with commas
  mutate(name = paste(name, collapse = ",") %>% str_trim()) %>%
  ungroup() %>%
  distinct(user_id, .keep_all = T) %>%
  select("class_name" = name, user_id)


# Get final users df
users <- facilityusers %>%
  # filter out admins and coaches to get list of users
  filter(!id %in% roles$user_id) %>%
  # join the users df to the groups df by user_id
  left_join(
    learners_and_groups,
    by = c("id" = "user_id")
  ) %>%
  # join the users df to the classrooms df by user_id
  left_join(
    learners_and_grades,
    by = c("id" = "user_id")
  ) %>%
  # Get first name and last name using functions from dbhelpers
  mutate(
    first_name = dbhelpers::get_first_name(full_name),
    last_name = dbhelpers::get_last_name(full_name)
  ) %>%
  select(
    user_id = id,
    first_name,
    last_name,
    username,
    class_name,
    group_name
  )


# Loading into Baseline database ---------------------------------------------

# get database credentials for baseline database from environment variables
bl_db_name <- Sys.getenv("BASELINE_DATABASE_NAME")
bl_db_host <- Sys.getenv("BASELINE_DATABASE_HOST")
bl_db_user <- Sys.getenv("BASELINE_DATABASE_USER")
bl_db_passwd <- Sys.getenv("BASELINE_DATABASE_PASSWORD")
bl_db_port <- Sys.getenv("BASELINE_DATABASE_PORT")

# connect to test responses database
baseline_conn <- dbPool(
  pg,
  dbname = bl_db_name,
  host = bl_db_host,
  port = bl_db_port,
  user = bl_db_user,
  password = bl_db_passwd
)

# clear out the users table
remove_users_query <- dbGetQuery(baseline_conn, "delete from users;")

# clear out the device table (important if swapdb is used or device name changes)
remove_device_name_query <- dbGetQuery(baseline_conn, "delete from device;")

# write the users df to the users table
dbWriteTable(
  baseline_conn,
  "users",
  users,
  append = TRUE,
  row.names = FALSE
)

# write the facility name to the device table
dbWriteTable(
  baseline_conn,
  "device",
  facility_name,
  append = TRUE,
  row.names = FALSE
)

# Close the pool connection
poolClose(baseline_conn)
