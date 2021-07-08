# prevent displaying warning messages from script on console(errors will still show)
options(warn = -1)
# suppress messages when loading package
suppressMessages(library(timeDate))
suppressMessages(library(plyr))
suppressMessages(library(dplyr))
suppressMessages(library(RPostgreSQL))
suppressMessages(library(stringr))
suppressMessages(library(rebus))


# Connect to baseline database and fetch data -------------------------------------------

bl_db_name <- Sys.getenv("BASELINE_DATABASE_NAME")
bl_db_host <- Sys.getenv("BASELINE_DATABASE_HOST")
bl_db_user <- Sys.getenv("BASELINE_DATABASE_USER")
bl_db_passwd <- Sys.getenv("BASELINE_DATABASE_PASSWORD")
bl_db_port <- Sys.getenv("BASELINE_DATABASE_PORT")

# Connect to test responses database
pg <- dbDriver("PostgreSQL")
conn <- dbConnect(
  pg,
  dbname = bl_db_name,
  host = bl_db_host,
  port = bl_db_port,
  user = bl_db_user,
  password = bl_db_passwd
)

# get test responses, join with user_id
tresponses_query <-
  "select r.*, tm.testmaxscore from responses r 
  left join test_marks tm
  on r.test = tm.test_id
  and r.module = tm.module
  and r.course = tm.course"

ext_eval_query <-
  "select e.*, tm.testmaxscore from ext_eval_responses e
  left join test_marks tm
  on e.test = tm.test_id
  and e.module = tm.module
  and e.course = tm.course"


device_name_query <- "select * from device"

# Fetch the test responses
tresponses <- dbGetQuery(conn, tresponses_query)

# Fetch external evaluation responses
ext_eval <- dbGetQuery(conn, ext_eval_query)

# Bind the two together and fill any empty columns with NA
tresponses <- tresponses %>% plyr::rbind.fill(ext_eval)

# get device name
device_name <- dbGetQuery(conn, device_name_query)
device_name <- substring(device_name$name, 1, 3)

# clean up and close database connection
dbDisconnect(conn)


# helper function to check if test responses exist for the request --------
check_tests_in_curr_month <- function(year_month, tresponses) {
  upper_limit <- paste("01-", year_month, sep = "")
  # regular expression to check if the user input is a valid month and year, and in the form mm-yy
  regexp <- START %R%
    # starts with 01
    "01" %R%
    # followed by "-"
    "-" %R%
    # followed by 0 then 0-9
    # or 1 then 0-2 (01-12 are the only valid months of the year)
    or(
      "0" %R% char_class("0-9"),
      "1" %R% char_class("0-2")
    ) %R%
    # followed by "-"
    "-" %R%
    # followed by any two digits (year)
    # it is assumed that the year is in the 21st century
    repeated(DIGIT, 2, 2) %R%
    # end of the string
    END

  # check if its a valid date and correct number of characters. stops the program if input not fit
  if (!(grepl(pattern = regexp, x = upper_limit, perl = TRUE)) | (nchar(upper_limit) > 8)) {
    stop("Please enter a valid month and year mm-yy e.g 02-17")
  }
  # with variable from above date, parse into date and get last day in month then convert into proper date format
  upper_limit <- as.Date(timeLastDayInMonth(strftime(upper_limit, "%d-%m-%y"), format = "%y-%m-%d"))
  # Need to get end of month in standard format before chopping it up for grepping. Need it for monthend column in final csv file

  upper_limit <- substring(upper_limit, 1, 7)
  tests_for_chosen_month <- tresponses %>% filter(grepl(upper_limit, test_date))

  # if no tests are found for the requested month, disconnect from the database and stop the program
  if (nrow(tests_for_chosen_month) == 0) {
    dbDisconnect(conn)
    stop("No tests found for the requested month. Nothing to extract")
  }
}


# Helper function to set empty strings to 0 and otherwise return t --------


empty_as_zero <- function(x) {
  if (is.na(x)) {
    return("0")
  }
  if (x == "") {
    return("0")
  }
  else {
    return(x)
  }
}



# Function to preprocess testresponses ------------------------------------


preproc_tresponses <- function(tresponses_raw) {
  # Create empty dataframe identiical to tresponses for next step
  tmp_df <- tresponses_raw[FALSE, ]

  # Loop through each row in tresponses. set empty string to 0 on cols that are within a test's max score
  # Leave all others as empty
  for (i in 1:nrow(tresponses_raw)) {
    row <- tresponses_raw[i, ]
    q1_index <- which(names(row) == "q1")
    q_max_index <- which(names(row) == paste0("q", row$testmaxscore))
    row[q1_index:q_max_index] <- lapply(row[q1_index:q_max_index], empty_as_zero)
    tmp_df <- tmp_df %>% rbind(row)
  }

  # Set the tmp dataframe to the real thing
  tr_proc <- tmp_df

  # Create vector of expected question columns (q1 to q126)
  expected_qcols <- paste0("q", c(1:126))

  # Add any missing q columns, with a value of empty string
  missing_qcols <- expected_qcols %>%
    setdiff(names(tr_proc)) %>%
    tibble::enframe() %>%
    mutate(name = "") %>%
    tidyr::spread(key = value, value = name)
  # bind the missing cols to tresponses
  tr_proc <- tr_proc %>% bind_cols(missing_qcols)

  # rename question cols to start with res and have leading zeroes depending on the question number
  # e.g q1 becomes res001, q20 becomes res020, but a 3-digit question number will not have leading zeroes
  names(tr_proc) <- case_when(
    str_detect(names(tr_proc), START %R% "q" %R% digit(1) %R% END) ~ str_replace(names(tr_proc), "q", "res00"),
    str_detect(names(tr_proc), START %R% "q" %R% digit(2) %R% END) ~ str_replace(names(tr_proc), "q", "res0"),
    str_detect(names(tr_proc), START %R% "q" %R% digit(3) %R% END) ~ str_replace(names(tr_proc), "q", "res"),
    TRUE ~ names(tr_proc)
  )

  # Final touches and column selection
  tr_proc <- tr_proc %>%
    # remove hyphens from user_id(uuid)
    mutate(user_id = str_replace_all(user_id, "-", "")) %>%
    # add centre column
    mutate(centre = rep(device_name)) %>%
    # add valid column(default to true)
    mutate(valid = rep(1)) %>%
    # Filter out tests that have no max score
    filter(!is.na(testmaxscore)) %>%
    # arrange columns, let all familiar columns appear on the left,
    # then all cols from res001...res126 appear on the right
    select(
      response_id,
      user_id,
      sex,
      grade,
      gr7_exam_number,
      test_date,
      centre,
      module,
      course,
      test,
      valid,
      # All the res columns sorted in alphabetical (lexical) order
      names(tr_proc)[str_detect(names(tr_proc), "res" %R% one_or_more(DIGIT))] %>% sort()
    )

  # return the processed testresponses df
  return(tr_proc)
}


# Simple function to generate filename of csv report in desired  --------


generate_filename <- function(report, date) {
  # Put generated file in a folder called reports/baseline in home directory
  # Generate filename based on name of report and user input
  filename <- paste("~/.reports/baseline/", report, device_name, "_", date, ".csv", sep = "")
}


# Function to get data extract only for month that user inputs ------------

baseline <- function(year_month, tresponses) {
  # With user input from command line, create complete date by prefixing with 01
  upper_limit <- paste("01-", year_month, sep = "")
  # Regular expression to check if the user input is a valid month and year, and in the form mm-yy
  regexp <- START %R%
    # starts with 01
    "01" %R%
    # followed by "-"
    "-" %R%
    # followed by 0 then 0-9
    # or 1 then 0-2 (01-12 are the only valid months of the year)
    or(
      "0" %R% char_class("0-9"),
      "1" %R% char_class("0-2")
    ) %R%
    # followed by "-"
    "-" %R%
    # followed by any two digits (year)
    # it is assumed that the year is in the 21st century
    repeated(DIGIT, 2, 2) %R%
    # end of the string
    END

  # Check if its a valid date and correct number of characters. stops the program if input not fit
  if (!(grepl(pattern = regexp, x = upper_limit, perl = TRUE)) | (nchar(upper_limit) > 8)) {
    stop("Please enter a valid month and year mm-yy e.g 02-17")
  }
  # With variable from above date, parse into date and get last day in month then convert into proper date format
  upper_limit <- as.Date(timeLastDayInMonth(strftime(upper_limit, "%d-%m-%y"), format = "%y-%m-%d"))
  # Need to get end of month in standard format before chopping it up for grepping. Need it for monthend column in final csv file

  upper_limit <- substring(upper_limit, 1, 7)
  tests_for_chosen_month <- tresponses %>% filter(grepl(upper_limit, test_date))
  write.csv(
    tests_for_chosen_month,
    file = generate_filename(
      "baseline_",
      year_month
    ),
    quote = FALSE,
    col.names = TRUE,
    row.names = FALSE,
    na = ""
  )
  system("echo Baseline extracted successfully!")
  quit(save = "no")
}


# Get user input from the command line
input <- commandArgs(TRUE)

# Check if tests exist for the requested month or stop the program if they do not
check_tests_in_curr_month(input, tresponses)

# Preprocess the testresponses using the function declared above
tresponses_processed <- preproc_tresponses(tresponses)

# Get the data extract for the inputed month
baseline(input, tresponses_processed)