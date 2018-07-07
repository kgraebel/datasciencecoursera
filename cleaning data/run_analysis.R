# Kevin Graebel - Getting and Cleaning Data Project

# Assume the file is downloaded and extracted, and the wd is set to the 
# UCI HAR Dataset folder, and the test and train are in default folders

run_analysis <- function() {

    # Load necessary libraries
    library(dplyr)
    
    # First, read data as tablular format
    trainSet <- read.table("./train/X_train.txt")
    trainLabel <- read.table("./train/Y_train.txt")
     
    testSet <- read.table("./test/X_test.txt")
    testLabel <- read.table("./test/Y_test.txt")
    
    # Combine data sets together (just add to bottom, don't merge)
    comboSet <- rbind(trainSet, testSet)
    
    # Keep label separate so you can add back in after filtering
    comboLabel <- rbind(trainLabel, testLabel)
    colnames(comboLabel) <- "activity"
    
    # Pull in data labels for each column
    measurementLabels <- read.table("./features.txt")
    
    # Concatenate number and row to ensure unique names
    measurementLabels$labels <- paste(measurementLabels$V1,
                                      measurementLabels$V2, sep=" - ")
    
    # Apply appropriate names to the columns
    colnames(comboSet) <- measurementLabels$labels
    
    # extra only the values that include mean() or std() in the title"
    # add the labels to the first column to help sort
    
    meanSet <- cbind(comboLabel, 
                     select(comboSet, contains("mean()")),
                     select(comboSet, contains("std()")))

    # need to replace numbers in comboLabel with descriptive names
    
    for (i in 1:nrow(meanSet)) {
        
        # Using activity_labels file, replace numbers with suggested words
        if(meanSet$activity[i] == 1) {
            meanSet$activity[i] <- "WALKING"
        }   
     
        else if (meanSet$activity[i] == 2) {
            meanSet$activity[i] <- "WALKING_UPSTAIRS"    
        }
        
        else if (meanSet$activity[i] == 3) {
            meanSet$activity[i] <- "WALKING_DOWNSTAIRS"    
        }
        
        else if (meanSet$activity[i] == 4) {
            meanSet$activity[i] <- "SITTING"    
        }
        
        else if (meanSet$activity[i] == 5) {
            meanSet$activity[i] <- "STANDING"    
        }
        
        else if (meanSet$activity[i] == 6) {
            meanSet$activity[i] <- "LAYING"    
        }
    }
   
    # Create a new data set with just the average of each activity variable
    
    setSummary <- group_by(meanSet, activity)
    
    tidySummary <- summarize_all(setSummary, funs(mean))
    
    #Output  tidy summary to file
    
    write.table(tidySummary, file = "tidyData.txt", row.names = FALSE)
}