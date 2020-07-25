options(warn=-1)
#suppress messages when loading package
suppressMessages(library(timeDate))
library(plyr)
library(readr)
#suppress messages when loading package
suppressMessages(library(dplyr))
library(DBI)
library(RPostgreSQL)

# connect to responses database 
bl_db_name = Sys.getenv("BASELINE_DATABASE_NAME")
bl_db_host = Sys.getenv("BASELINE_DATABASE_HOST")
bl_db_user = Sys.getenv("BASELINE_DATABASE_USER")
bl_db_passwd = Sys.getenv("BASELINE_DATABASE_PASSWORD")
bl_db_port = Sys.getenv("BASELINE_DATABASE_PORT")

# connect to test responses database
pg <- dbDriver("PostgreSQL")
conn <-  dbConnect(pg, dbname= bl_db_name, host= bl_db_host, port= bl_db_port, user= bl_db_user, password= bl_db_passwd)

# Insert the contents of the users csv file into the users table on baseline
insert_responses <- function(input_file){
	# Read the contents of the file supplied into a dataframe
	users_df <- read.csv(input_file,stringsAsFactors = FALSE)

	# Set the group name = "Lteracy"
	users_df$group_name <- rep('Literacy',nrow(users_df))

	# Write to the users table
	dbWriteTable(conn,"users",users_df,append = TRUE, row.names = FALSE)

	# Disconnect the database connection
	dbDisconnect(conn)
}

# Capure arguments supplied in the command line
input <- commandArgs(TRUE)

# Call insert responses with the file path supplied in the command line
insert_responses(input)
