# Import tables and generate filename script
#source('get_dbtables.R',chdir = T)
#source('generate_filename.R',chdir = T)
#prevent displaying warning messages from script on console(errors will still show)
options(warn=-1)
#suppress messages when loading package
suppressMessages(library(timeDate))
library(plyr)
#suppress messages when loading package
suppressMessages(library(dplyr))
library(RSQLite)


# connect to KA database 
sqlite <- dbDriver("SQLite")
dbfile <- "~/.baseline_testing/public/test_responses.sqlite"
conn <- dbConnect(sqlite, dbfile)

#get users
tresponses_query <- dbSendQuery(conn,"select u.user_id,u.group_name,r.* from responses r join users u where r.username = u.username")
  #filter out deleted users and coaches, then select only columns needed for joins later in script
tresponses <- dbFetch(tresponses_query)

#clean up and close database connection
dbDisconnect(conn)

ka_db <- "~/.kalite/database/data.sqlite"
conn2 <- dbConnect(sqlite, ka_db)

#get device name
#device name derived by getting id of own device from metadata, then joining to devices config table
device_query <- dbSendQuery(conn2,"SELECT * FROM securesync_device")
device <- dbFetch(device_query) %>% select(id,name)

meta_query <- dbSendQuery(conn2,"SELECT * FROM securesync_devicemetadata")
device_meta <- dbFetch(meta_query) %>% select(id,device_id,is_own_device)
device_name <- device_meta %>% filter(is_own_device == 1) %>% left_join(device,by=c("device_id" = "id"))
device_name <- substring(device_name$name,1,3)

dbDisconnect(conn2)


# Simple function to generate filename of csv report in desired format
generate_filename <- function(report,date){
  # put generated file in a folder called reports in home directory, and generate filename based on name of report and user input
  filename <- paste("~/reports/baseline/",report,device_name,"_numeracy_",date,".csv",sep = "")
}

# Function to get data extract only for month that user inputs
baseline <- function(year_month) {
  #with user input from command line, create complete date by prefixing with 01
  upper_limit <- paste("01-",year_month,sep="")
  #regular expression to check if the user input is a valid month and year, and in the form mm-yy
  regexp <-'((?:(?:[0-2]?\\d{1})|(?:[3][01]{1}))[-:\\/.](?:[0]?[1-9]|[1][012])[-:\\/.](?:(?:\\d{1}\\d{1})))(?![\\d])'
  #check if its a valid date and correct number of characters. stops the program if input not fit
  if(!(grepl(pattern = regexp,x=upper_limit,perl = TRUE)) | (nchar(upper_limit) > 8)) stop("Please enter a valid month and year mm-yy e.g 02-17")
  # with variable from above date, parse into date and get last day in month then convert into proper date format
  upper_limit <- as.Date(timeLastDayInMonth(strftime(upper_limit,"%d-%m-%y"),format = "%y-%m-%d"))
  # Need to get end of month in standard format before chopping it up for grepping. Need it for monthend column in final csv file
  
  upper_limit <- substring(upper_limit,1,7)
  tests_for_chosen_month <- tresponses %>% filter(grepl(upper_limit, test_date))
  write.csv(tests_for_chosen_month, file = generate_filename("baseline_",year_month) ,col.names = TRUE, row.names = FALSE,na="")
  system("echo Baseline extracted successfully!")
  quit(save="no")
}



input<- commandArgs(TRUE)

baseline(input)
