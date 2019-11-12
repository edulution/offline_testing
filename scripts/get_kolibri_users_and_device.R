suppressMessages(library(timeDate))

suppressMessages(library(tidyr))
suppressMessages(library(plyr))
suppressMessages(library(dplyr))

# load new packages for kolibri data extraction
suppressMessages(library(tools))
suppressMessages(library(gsubfn))

# load postgresql library
suppressMessages(library(DBI))
suppressMessages(library(RSQLite))
suppressMessages(library(RPostgreSQL))
suppressMessages(library(stringr))


# helper functions
#==================
# helper function to get last name
get_last_name <- function(full_name) {
  # if the full name is blank or there is only one name
  if(nchar(full_name) == 0 || length(strsplit(full_name,' ')[[1]]) == 1){
    last_name <- ''  
  }
  
  else{
    last_name <- paste(strsplit(full_name,' ')[[1]][-1],collapse = ' ')
  }
  return(last_name)
}

# helper function to get first name
get_first_name <- function(full_name) {
  
  if(nchar(full_name) == 0 || length(strsplit(full_name,' ')[[1]]) == 1){
    first_name <- ''  
  }
  else{
    first_name <- paste(strsplit(full_name,' ')[[1]][1],collapse = ' ')
  }
  return(toString(first_name))
}


#----------------
# Kolibri database

# connect to Kolibri database 
pg <- dbDriver("PostgreSQL")
# get database credentials from environment variables
db_name = Sys.getenv("KOLIBRI_DATABASE_NAME")
db_host = Sys.getenv("KOLIBRI_DATABASE_HOST")
db_user = Sys.getenv("KOLIBRI_DATABASE_USER")
db_passwd = Sys.getenv("KOLIBRI_DATABASE_PASSWORD")
db_port = Sys.getenv("KOLIBRI_DATABASE_PORT")

kolibri_conn <-  dbConnect(pg, dbname=db_name, host = db_host, port = db_port, user=db_user, password=db_passwd)

#facilityysers
facilityusers <- dbGetQuery(kolibri_conn,"SELECT * FROM kolibriauth_facilityuser")

#collections
collections <- dbGetQuery(kolibri_conn,"SELECT * FROM kolibriauth_collection")

#memberships
memberships <- dbGetQuery(kolibri_conn,"SELECT * FROM kolibriauth_membership")

#roles
roles <- dbGetQuery(kolibri_conn,"SELECT * FROM kolibriauth_role")


#get the default facility id and from it get the device name(facility name)
default_facility_id <- dbGetQuery(kolibri_conn,"SELECT default_facility_id FROM device_devicesettings")

# close the connection
dbDisconnect(kolibri_conn)


#filter out admins and coaches to get list of users
users <- facilityusers %>% filter(!id %in% roles$user_id)

# get the device name (name of the default facility id)
default_facility_id <- default_facility_id$default_facility_id
facility_name <- collections %>% filter(id == default_facility_id) %>% select(name)

#join collections to memberships. (used for getting user groups)
memberships <- memberships %>% left_join(collections,by=c("collection_id"= "id"))

# get dataframe containing learners and groups they belong to
learners_and_groups <- memberships %>% filter(kind == 'learnergroup') %>% distinct(user_id,.keep_all = TRUE) %>% select(c(name,user_id))

# select only the name of the group and the user_id
learners_and_groups <- learners_and_groups %>% select(c(name,user_id)) %>% rename(group_name = name)

# join the users table to the groups table by user_id
users <- users %>% left_join(learners_and_groups, by=c("id"="user_id"))  %>% select(c(id,username,full_name,group_name))

# derive the first name and last name columns
users$first_name <- sapply(users$full_name,get_first_name)
users$last_name <- sapply(users$full_name,get_last_name)

# drop the full name column
# change the user_id to a plain character string
users <- users %>% select(-c(full_name)) %>% rename(user_id = id) %>% mutate(user_id = str_replace_all(user_id,'-',''))


#---------------------
# Baseline database

# get database credentials for baseline database from environment variables
bl_db_name = Sys.getenv("BASELINE_DATABASE_NAME")
bl_db_host = Sys.getenv("BASELINE_DATABASE_HOST")
bl_db_user = Sys.getenv("BASELINE_DATABASE_USER")
bl_db_passwd = Sys.getenv("BASELINE_DATABASE_PASSWORD")
bl_db_port = Sys.getenv("BASELINE_DATABASE_PORT")

# connect to test responses database
tresponses_conn <-  dbConnect(pg, dbname= bl_db_name, host= bl_db_host, port= bl_db_port, user= bl_db_user, password= bl_db_passwd)

# clear out the users table
remove_users_query <- dbSendQuery(tresponses_conn,"delete from users;")

# clear the result of the query
dbClearResult(remove_users_query)

# clear out the device table (important if swapdb is used or device name changes)
remove_device_name_query <- dbSendQuery(tresponses_conn,"delete from device;")
#clear the result from the query above
dbClearResult(remove_device_name_query)

#write the users to the users table
dbWriteTable(tresponses_conn,"users",users,append = TRUE)

#write the facility name to the device table
dbWriteTable(tresponses_conn,"device",facility_name, append = TRUE)

# disconnect the connection
dbDisconnect(tresponses_conn)





