library(dplyr)
library(stringr)
setwd("~/Desktop/ds_capstone/predictiontest")
allngrams <- readRDS("ngrams.rds")

test <- function(i){
  #get random line from test data
  #set.seed(123)
  line <- sample(tempTestData, 1)
  
  #extract five words from it
  fiveWords <- word(line, 1:5)
  
  #create tuple vector of first four words and last word
  first <- paste(fiveWords[1:4], collapse = " ")
  last <- fiveWords[5]
  match <- c(first, last)
  
  #run first four words through algorithm
  result <- algorithm(match[1])[1:i,]
  
  #if any of top three results matches last word add "1" to vector, if not "0"
  if(match[2] %in% result){
    x <- TRUE
  }
  else{
    x <- FALSE
  }
  print(line)
  print(result)
}  
   
#calculate precision rate
accuracyTest <- function(n,i){
  set.seed(123)
  result <- replicate(n, test(i))
  accuracy <- sum(result,na.rm=TRUE)/n
  print(table(result))
  print(accuracy)
}

#calculate test time
timeTest <- function(n,i){
  userTime <- replicate(n, system.time(test(i))[1])
#  print(userTime)
  print(mean(userTime))
}