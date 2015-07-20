main <- function() {
  
  require(reshape2)
  
  #prepare labels (will use further)
  aclabels <- read_activitylabels()
  prlabels <- prepare_featurelabels()
  
  ###################
  ## TEST DATA ##
  
  #read TEST data
  data_test <- read.fwf("test/X_test.txt", widths = prlabels$indices, col.names = prlabels$names)
  
  #add subjects there
  subjects <- read.table("test/subject_test.txt", col.names = c("subject"))
  data_test$subject <- subjects$subject
  
  #add activities there
  activities <- read.table("test/y_test.txt", col.names = c("activity"))
  data_test$activity <- factor(activities$activity, labels = aclabels$activity_name)
  
  ###################
  ## TRAIN DATA ##
  
  #all the same for TRAIN data
  data_train <- read.fwf("train/X_train.txt", widths = prlabels$indices, col.names = prlabels$names)
  
  subjects <- read.table("train/subject_train.txt", col.names = c("subject"))
  data_train$subject <- subjects$subject
  
  activities <- read.table("train/y_train.txt", col.names = c("activity"))
  data_train$activity <- factor(activities$activity, labels = aclabels$activity_name)
  

  ###################
  ## MERGING&PREPARING ##
  
  all_data <- rbind(data_test, data_train)
  
  # Reshape the data.
  molten_data <- melt(all_data, id = c("subject", "activity"))
  result <- dcast(molten_data, subject + activity ~ variable, mean) 
  
  
  write.table(result, "result.txt", row.names = FALSE, quote = FALSE)
  
}



read_activitylabels <- function() {
  labels <- read.table("activity_labels.txt", sep = " ", col.names = c("activity_id", "activity_name"))
  labels
}

prepare_featurelabels <- function() {
  labels <- read.table("features.txt", sep = " ", col.names = c("feature_id", "feature_name"))
  
  labels$ok = grepl("mean()", labels$feature_name) | grepl("std()", labels$feature_name)
 
  indices = numeric()
  for (i in 1:nrow(labels)) {
    
    if (labels[i,"ok"]) {
      
      indices = c(indices, 16)
      
    } else {indices = c(indices, -16)}
    
    
  }
  
  names = labels[labels$ok,"feature_name"]
  
  list("indices" = indices, "names" = names)
  
}




