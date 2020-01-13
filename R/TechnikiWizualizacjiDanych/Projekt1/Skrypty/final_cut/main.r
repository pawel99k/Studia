library(haven)
library(dplyr)
library(stringr)
library(foreign)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

stud2015 <- read.spss("CY6_MS_CMB_STU_QQQ.sav", use.value.labels = TRUE, to.data.frame = TRUE)
students2 <- read_sas("cy6_ms_cmb_stu_qq2.sas7bdat")
students <- read_sas("cy6_ms_cmb_stu_qqq.sas7bdat")

get_data_of_questions <- function(questions){
  require(stringr)
  # all titles of questions 
  all_questions_names <- colnames(students)
  
  # basic info about student, Country 3-letter code, School ID, Student ID, Language of questionnaire 3-digits
  basic_info <- students[,c(2,3,4,21)] #jak cos to usunalem '29' 6 listopada
  
  # all questions is dataframe that will be returned 
  all_questions <- basic_info
  
  for(question in questions[-1]){
    
    # setting regexp to find all sub questions to one main question
    regEXP <- paste0(questions[1],"0*",toString(question),".{5}\\b")
    
    # extracting all subquestions to a question
    found_questions <- str_extract(all_questions_names,regEXP)
    
    # adding found subquestions to dataframe
    all_questions <-cbind(all_questions,students[found_questions[!is.na(found_questions)]])
    
  }
  return(all_questions)
}


get_data_of_questions2 <- function(questions){ #nowa fukncja dla drugiego
  require(stringr)
  # all titles of questions 
  all_questions_names <- colnames(students2)
  
  # basic info about student, Country 3-letter code, School ID, Student ID, Language of questionnaire 3-digits
  basic_info <- students2[,c(2,3,4)] #jak cos to usunalem '29' 6 listopada
  
  # all questions is dataframe that will be returned 
  all_questions <- basic_info
  
  for(question in questions[-1]){
    
    # setting regexp to find all sub questions to one main question
    regEXP <- paste0(questions[1],"0*",toString(question),".{5}\\b")
    
    # extracting all subquestions to a question
    found_questions <- str_extract(all_questions_names,regEXP)
    
    # adding found subquestions to dataframe
    all_questions <-cbind(all_questions,students2[found_questions[!is.na(found_questions)]])
    
  }
  return(all_questions)
}
