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
suppressMessages(library(RPostgreSQL))
suppressMessages(library(stringr))

# connect to responses database 
bl_db_name = Sys.getenv("BASELINE_DATABASE_NAME")
bl_db_host = Sys.getenv("BASELINE_DATABASE_HOST")
bl_db_user = Sys.getenv("BASELINE_DATABASE_USER")
bl_db_passwd = Sys.getenv("BASELINE_DATABASE_PASSWORD")
bl_db_port = Sys.getenv("BASELINE_DATABASE_PORT")


# connect to test responses database
pg <- dbDriver("PostgreSQL")
conn <-  dbConnect(
  pg,
  dbname= bl_db_name,
  host= bl_db_host,
  port= bl_db_port,
  user= bl_db_user,
  password= bl_db_passwd)

# Simple function to generate filename of csv report in desired format
input<- commandArgs(TRUE)

# helper function to check if test responses exist for the requested month
check_tests_in_curr_month <- function(year_month,tresponses){
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

  # if no tests are found for the requested month, disconnect from the database and stop the program
  if(nrow(tests_for_chosen_month)==0){
    dbDisconnect(conn)
    stop('No tests found for the requested month. Nothing to extract')
  }
}

#get test responses, join with user_id
tresponses_query <- dbSendQuery(
  conn,
  "select r.*, tm.testmaxscore from responses r left join test_marks tm on r.test = tm.test_id and r.module = tm.module and r.course = tm.course")
tresponses <- dbFetch(tresponses_query)

# check if tests exist for the requested month or stop the program if they do not
check_tests_in_curr_month(input,tresponses)


#get device name
device_name_query <- dbSendQuery(conn,"select * from device")
device_name <- dbFetch(device_name_query)
device_name <- substring(device_name$name,1,3)


#clean up and close database connection
dbDisconnect(conn)

# columns we wish to drop when submitting the report
drop_cols <-c("coach_id","username")

#rename user_id column to header(for load with load_answers function)
tresponses <- tresponses %>%
  # remove unecessary columns
  select(-one_of(drop_cols)) %>%
  mutate(
    # remove hyphens from user_id(uuid)
    user_id = str_replace_all(user_id,'-',''),
    # add centre column
    centre=rep(device_name),
    # add valid column(default to true)
    valid=rep(1)) %>%
  rename(HEADER = user_id) %>%
  #arrange columns, let all columns appear on the left, then all cols from q1...q70 appear on the right
  select(
    HEADER,
    sex,
    grade,
    gr7_exam_number,
    test_date,
    centre,
    module ,
    course,
    test,
    valid,
    testmaxscore,
    everything())

#helper function to set empty strings to 0 and otherwise return the actual string
empty_as_zero<- function(x){
  if(is.na(x)){
    return("0")
  }
  if(x == ""){
    return("0")
  }
  else{
    return(x)
  }
}

#create empty dataframe identiical to tresponses for next step
tresponses_tmp<-tresponses[FALSE,]

#loop through each row in tresponses. set empty string to 0 on cols that are within a test's max score
#leave all others as empty
for(i in 1:nrow(tresponses)) {
  row <- tresponses[i,]
  q1_index<-which(names(row)=='q1')
  q_max_index<-which(names(row)==paste0("q",row$testmaxscore))
  row[q1_index:q_max_index]<-lapply(row[q1_index:q_max_index],empty_as_zero)
  tresponses_tmp<- tresponses_tmp %>% rbind(row)
}

#set the tmp dataframe to the real thing
tresponses<-tresponses_tmp

#add missing cols
tresponses$res071=""
tresponses$res072=""
tresponses$res073=""
tresponses$res074=""
tresponses$res075=""
tresponses$res076=""
tresponses$res077=""
tresponses$res078=""
tresponses$res079=""
tresponses$res080=""
tresponses$res081=""
tresponses$res082=""
tresponses$res083=""
tresponses$res084=""
tresponses$res085=""
tresponses$res086=""
tresponses$res087=""
tresponses$res088=""
tresponses$res089=""
tresponses$res090=""
tresponses$res091=""
tresponses$res092=""
tresponses$res093=""
tresponses$res094=""
tresponses$res095=""
tresponses$res096=""
tresponses$res097=""
tresponses$res098=""
tresponses$res099=""
tresponses$res100=""
tresponses$res101=""
tresponses$res102=""
tresponses$res103=""
tresponses$res104=""
tresponses$res105=""
tresponses$res106=""
tresponses$res107=""
tresponses$res108=""
tresponses$res109=""
tresponses$res110=""
tresponses$res111=""
tresponses$res112=""
tresponses$res113=""
tresponses$res114=""
tresponses$res115=""
tresponses$res116=""
tresponses$res117=""
tresponses$res118=""
tresponses$res119=""
tresponses$res120=""
tresponses$res121=""
tresponses$res122=""
tresponses$res123=""
tresponses$res124=""
tresponses$res125=""
tresponses$res126=""


#rename question cols to have res..
tresponses<- tresponses %>% rename(res001 = q1)
tresponses<- tresponses %>% rename(res002 = q2)
tresponses<- tresponses %>% rename(res003 = q3)
tresponses<- tresponses %>% rename(res004 = q4)
tresponses<- tresponses %>% rename(res005 = q5)
tresponses<- tresponses %>% rename(res006 = q6)
tresponses<- tresponses %>% rename(res007 = q7)
tresponses<- tresponses %>% rename(res008 = q8)
tresponses<- tresponses %>% rename(res009 = q9)
tresponses<- tresponses %>% rename(res010 = q10)
tresponses<- tresponses %>% rename(res011 = q11)
tresponses<- tresponses %>% rename(res012 = q12)
tresponses<- tresponses %>% rename(res013 = q13)
tresponses<- tresponses %>% rename(res014 = q14)
tresponses<- tresponses %>% rename(res015 = q15)
tresponses<- tresponses %>% rename(res016 = q16)
tresponses<- tresponses %>% rename(res017 = q17)
tresponses<- tresponses %>% rename(res018 = q18)
tresponses<- tresponses %>% rename(res019 = q19)
tresponses<- tresponses %>% rename(res020 = q20)
tresponses<- tresponses %>% rename(res021 = q21)
tresponses<- tresponses %>% rename(res022 = q22)
tresponses<- tresponses %>% rename(res023 = q23)
tresponses<- tresponses %>% rename(res024 = q24)
tresponses<- tresponses %>% rename(res025 = q25)
tresponses<- tresponses %>% rename(res026 = q26)
tresponses<- tresponses %>% rename(res027 = q27)
tresponses<- tresponses %>% rename(res028 = q28)
tresponses<- tresponses %>% rename(res029 = q29)
tresponses<- tresponses %>% rename(res030 = q30)
tresponses<- tresponses %>% rename(res031 = q31)
tresponses<- tresponses %>% rename(res032 = q32)
tresponses<- tresponses %>% rename(res033 = q33)
tresponses<- tresponses %>% rename(res034 = q34)
tresponses<- tresponses %>% rename(res035 = q35)
tresponses<- tresponses %>% rename(res036 = q36)
tresponses<- tresponses %>% rename(res037 = q37)
tresponses<- tresponses %>% rename(res038 = q38)
tresponses<- tresponses %>% rename(res039 = q39)
tresponses<- tresponses %>% rename(res040 = q40)
tresponses<- tresponses %>% rename(res041 = q41)
tresponses<- tresponses %>% rename(res042 = q42)
tresponses<- tresponses %>% rename(res043 = q43)
tresponses<- tresponses %>% rename(res044 = q44)
tresponses<- tresponses %>% rename(res045 = q45)
tresponses<- tresponses %>% rename(res046 = q46)
tresponses<- tresponses %>% rename(res047 = q47)
tresponses<- tresponses %>% rename(res048 = q48)
tresponses<- tresponses %>% rename(res049 = q49)
tresponses<- tresponses %>% rename(res050 = q50)
tresponses<- tresponses %>% rename(res051 = q51)
tresponses<- tresponses %>% rename(res052 = q52)
tresponses<- tresponses %>% rename(res053 = q53)
tresponses<- tresponses %>% rename(res054 = q54)
tresponses<- tresponses %>% rename(res055 = q55)
tresponses<- tresponses %>% rename(res056 = q56)
tresponses<- tresponses %>% rename(res057 = q57)
tresponses<- tresponses %>% rename(res058 = q58)
tresponses<- tresponses %>% rename(res059 = q59)
tresponses<- tresponses %>% rename(res060 = q60)
tresponses<- tresponses %>% rename(res061 = q61)
tresponses<- tresponses %>% rename(res062 = q62)
tresponses<- tresponses %>% rename(res063 = q63)
tresponses<- tresponses %>% rename(res064 = q64)
tresponses<- tresponses %>% rename(res065 = q65)
tresponses<- tresponses %>% rename(res066 = q66)
tresponses<- tresponses %>% rename(res067 = q67)
tresponses<- tresponses %>% rename(res068 = q68)
tresponses<- tresponses %>% rename(res069 = q69)
tresponses<- tresponses %>% rename(res070 = q70)

#remove testmaxscore column
tresponses<- tresponses %>% select(-testmaxscore)


generate_filename <- function(report,date){
  # put generated file in a folder called reports/baseline in home directory, and generate filename based on name of report and user input
  filename <- paste("~/.reports/baseline/",report,device_name,"_",date,".csv",sep = "")
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
  write.csv(
    tests_for_chosen_month,
    file = generate_filename("baseline_",year_month),
    quote=FALSE,
    col.names = TRUE,
    row.names = FALSE,
    na="")

  system("echo Baseline extracted successfully!")
  quit(save="no")
}

baseline(input)