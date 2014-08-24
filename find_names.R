find_names <- function(vect) {
  for (i in 1:length(vect)) {
    #print (c(i, ':'))
    if(!(length(grep('mean', vect[i])) > 0 |
         length(grep('std',  vect[i])) > 0 )) {
      vect[i] <- NA
    } 
  }
  remove <- c(NA)
  #droplevels(vect[! vect %in% remove])
  as.character(vect[! vect %in% remove])
}