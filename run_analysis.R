
run_analysis <- function() {
  # check that the current working directory is the root of the data set
  if (! "UCI HAR Dataset" %in% dir(include.dirs=TRUE)) {
    stop("Please set working directory to be the root of the dataset.")
  }
  source('find_names.R')
  
  # read the data in
  print('reading data...')
  train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
  train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
  train_s <- read.table("UCI HAR Dataset/train/subject_train.txt")
  
  test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
  test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
  test_s <- read.table("UCI HAR Dataset/test/subject_test.txt")
  
  column_names <- read.table("UCI HAR Dataset/features.txt")
  activity_names <- read.table("UCI HAR Dataset/activity_labels.txt")
  
  # combine the training and test data sets
  print('combining data sets...')
  train_y <- rbind(train_y, test_y)
  train_s <- rbind(train_s, test_s)
  train_x <- rbind(train_x, test_x)
  
  # label data set
  print('labeling and extracting mean std...')
  names(train_x) <- column_names$V2
  names(train_y) <- 'Activity'
  names(train_s) <- 'Subject'
  # extract mean and standard deviation
  keep <- find_names(column_names$V2)  # find names with 'mean' and 'std' in them
  #print(keep)
  train_x <- train_x[keep]
  #print(names(train_x))
  
  # descriptive activity names
  print('creating descriptive activity names...')
  for(i in 1:length(train_y)) {
    train_y[i] <- activity_names[train_y[i,1],2]
  }
  
  # final tidy data set
  print('creating tidy data set...')
  f <- as.factor(train_s$Subject)
  #print(dim(f))
  #print(dim(train_x))
  tidy <- tapply(train_x[,1], f, mean)
  for (i in 2:ncol(train_x)) {
    tidy <- cbind(tidy, tapply(train_x[,i], f, mean))
  }
  tidy <- as.data.frame(tidy)
  print(class(tidy))
  names(tidy) <- names(train_x)
  subj <- names(table(train_s))
  #subj <- c(c("0"), subj)
  tidy <- cbind(subj, tidy)
  #print(names(tidy))
  print(dim(tidy))
  print(dim(train_x))
  write.table(tidy,'tidy_data.txt', row.names=FALSE)
  tidy
}