options(warn = -1)
library(DBI)
library(dplyr)
library(stringr)
library(RPostgreSQL)

# Connect to baseline database --------------------------------------------
bl_db_name <- Sys.getenv("BASELINE_DATABASE_NAME")
bl_db_host <- Sys.getenv("BASELINE_DATABASE_HOST")
bl_db_user <- Sys.getenv("BASELINE_DATABASE_USER")
bl_db_passwd <- Sys.getenv("BASELINE_DATABASE_PASSWORD")
bl_db_port <- Sys.getenv("BASELINE_DATABASE_PORT")

pg <- dbDriver("PostgreSQL")
conn <- dbConnect(
  pg,
  dbname = bl_db_name,
  host = bl_db_host,
  port = bl_db_port,
  user = bl_db_user,
  password = bl_db_passwd
)


# Helper function to insert the contents of the users csv file into the users table on baseline
insert_responses <- function(input_file) {
  # Read the contents of the file supplied into a data frame
  users_df <- read.csv(input_file, stringsAsFactors = FALSE)

  # Set the group name = "Literacy"
  users_df$group_name <- rep("Literacy", nrow(users_df))

  # Get existing users from the baseline db
  existing_users <- dbGetQuery(conn, "SELECT * FROM users")

  # Filter out exisiting users from the users to be inserted
  # Remove all hyphens from existing user_ids to ensure string to string comparison
  users_df <- users_df %>% filter(!user_id %in% str_remove_all(existing_users$user_id,"-"))

  dbWriteTable(
    conn,
    "users",
    users_df,
    append = TRUE,
    row.names = FALSE
  )

  dbDisconnect(conn)
}

# Capture arguments supplied in the command line
input <- commandArgs(TRUE)

# Call insert responses with the file path supplied in the command line
insert_responses(input)
