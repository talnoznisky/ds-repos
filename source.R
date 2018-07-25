source('dependencies.r')

#set global objects
result <- data.frame(ngrams = character(), first = character(), last = character(), n = numeric())
allngrams <- readRDS('ngrams.rds') 
#allngrams <- allngrams

algorithm <- function(x,n){
  x <- x %>%
    tolower() %>%
    removePunctuation()
  x.split <- strsplit(x, " ")[[1]]
  x.length <- length(x.split)
  if(x.length > 4){
    x <- paste(tail(x.split,4),collapse=" ")
    x.split <- strsplit(x, " ")[[1]]
    x.length <- length(x.split)
  }
  x.search <- paste0(x ,collapse=" ")
  
  for(i in 1:x.length){
    result <- filter(allngrams, first == x)
    x <- paste(x.split[-(1:i)], collapse=" ")
  }
  if(all(!is.na(result))){
    if(nrow(result)<n){
      n<-nrow(result)
    }
      else{
        n <- n
      }
      
    unique(select(result,last))[1:n,]
  }
}
