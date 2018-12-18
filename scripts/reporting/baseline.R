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

#get test responses, join with user_id
tresponses_query<-dbSendQuery(conn,"select u.user_id,r.*, tm.testmaxscore from responses r  left join users u on r.username = u.username left join test_marks tm on r.test = tm.test_id and r.module = tm.module and r.course = tm.course")
tresponses<-dbFetch(tresponses_query) 

#get device name
device_name_query<-dbSendQuery(conn,"select * from device")
device_name<-dbFetch(device_name_query)
device_name <- substring(device_name$name,1,3)


#clean up and close database connection
dbDisconnect(conn)


#remove unecessary columns
drop_cols<-c("username","coach_id")
tresponses<- tresponses %>% select(-one_of(drop_cols))

#rename user_id column to header(for load with load_answers function)
tresponses<- rename(tresponses, HEADER = user_id)

#add centre column
tresponses<-tresponses %>% mutate(centre=rep(device_name))

#add valid column(default to true)
tresponses<-tresponses %>% mutate(valid=rep(1))

#arrange columns, let all columns appear on the left, then all cols from q1...q70 appear on the right
tresponses<- tresponses %>% select(HEADER,test_date,centre,module ,course,test,valid,testmaxscore,everything())

#helper function to set empty strings to 0 and otherwise return the actual string
empty_as_zero<- function(x){
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

from_vals<-c("q1","q2","q3","q4","q5","q6","q7","q8","q9","q10","q11","q12","q13","q14","q15","q16","q17","q18","q19","q20","q21","q22","q23","q24","q25","q26","q27","q28","q29","q30","q31","q32","q33","q34","q35","q36","q37","q38","q39","q40","q41","q42","q43","q44","q45","q46","q47","q48","q49","q50","q51","q52","q53","q54","q55","q56","q57","q58","q59","q60","q61","q62","q63","q64","q65","q66","q67","q68","q69","q70")

to_vals<-c("res001","res002","res003","res004","res005","res006","res007","res008","res009","res010","res011","res012","res013","res014","res015","res016","res017","res018","res019","res020","res021","res022","res023","res024","res025","res026","res027","res028","res029","res030","res031","res032","res033","res034","res035","res036","res037","res038","res039","res040","res041","res042","res043","res044","res045","res046","res047","res048","res049","res050","res051","res052","res053","res054","res055","res056","res057","res058","res059","res060","res061","res062","res063","res064","res065","res066","res067","res068","res069","res070")

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
tresponses<- tresponses %>% rename_at(vars(from_vals),function(x) to_vals)

#remove testmaxscore column
tresponses<- tresponses %>% select(-testmaxscore)

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
  write.csv(tests_for_chosen_month ,file = generate_filename("baseline_",year_month),quote=FALSE, col.names = TRUE, row.names = FALSE,na="")
  system("echo Baseline extracted successfully!")
  quit(save="no")
}



input<- commandArgs(TRUE)

baseline(input)
