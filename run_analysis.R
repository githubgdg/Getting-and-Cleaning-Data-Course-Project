## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average 
##       of each variable for each activity and each subject.

# Install packages needed for functions that will be used.
install.packages("data.table")
library("data.table")
install.packages("reshape2")
library("reshape2")

# Clean up workspace.
rm(list=ls())

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Create directory where files will be stored, delete first if exists.  Set as the working directory.
ifelse(dir.exists("get_clean_project"), unlink("get_clean_project", recursive = TRUE), FALSE)
dir.create("get_clean_project")
setwd("get_clean_project")

# Download and unzip zip file.
fileName <- file.path(getwd(), "UCI_HAR_dataset.zip")
download.file(fileUrl, fileName, method="libcurl")
unzip(fileName, overwrite = TRUE, exdir=".")

# TO DO : 1. Merges the training and the test sets to create one data set.
   # features.txt: List of all features.
   features <- read.table("./UCI HAR Dataset/features.txt")

   # Use feature names as column names.  X_test.txt : Test set and X_train.txt: Training set. 
   x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
   x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features[,2])

   # Merge data frames by rows.
   x <- rbind(x_test, x_train)

# TO DO : 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
   mean_std_Features <- features[grep("(mean|std)\\(", features[,2]),]
   mean_std <- x[,mean_std_Features[,1]]

# TO DO : 3. Uses descriptive activity names to name the activities in the data set.
   # y_test.txt: Test labels and y_train.txt: Training labels.
   y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c('activity'))
   y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))
   y <- rbind(y_test, y_train)

   # activity_labels.txt: Links the class labels with their activity name.
   activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt")

   # Replace y data set's id/number with activity name.
   for (i in 1:nrow(activity_names)) {
        id <- as.numeric(activity_names[i, 1])
        name <- as.character(activity_names[i, 2])
        y[y$activity == id, ] <- name
   }

# TO DO : 4. Appropriately labels the data set with descriptive variable names. 
   # Sample : "tBodyAcc.mean...Y" to "tBodyAcc_mean_Y" and "tBodyGyroMag.std.." to "tBodyGyroMag_std"
   # Replace "." of variable/column names with " " and trim names.
   names(mean_std) <- gsub("(^[[:space:]]+|[[:space:]]+$)", "", 
                           gsub(x = names(mean_std), pattern = "\\.", replacement = " ") )
   # Replace a space or multiple spaces with "_".
   names(mean_std) <- gsub("([[:space:]]+|[[:space:]])", "_", names(mean_std))


# TO DO : 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#               of each variable for each activity and each subject.

   subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))

   # subject_train.txt: Each row identifies the subject who performed the activity for each window sample. 
   # Its range is from 1 to 30.
   subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))

   # Merge subjects by row.
   subject <- rbind(subject_test, subject_train)
   average_by <- aggregate(mean_std, by = list(activity = y[,1], subject = subject[,1]), mean)

   write.csv(average_by, file='tidy_file.txt', row.names=FALSE)

   message("DONE - Run Analysis")

# End of Code.


# Running run_analysis.R
# Sample on how to run in R :  source("C:\\Users\\user_name\\Documents\\run_analysis.R")
# Choose Secure CRAN Mirrors
# Sample of last Running message :
#    DONE - Run Analysis
#    Warning message:
#    package ‘reshape2’ was built under R version 3.4.1 

# *** Test Result ***
# 1.) Check Unique Values

# Unique values of Activities and Subjects
# > head(read.csv("./UCI HAR Dataset/activity_labels.txt"))
#             X1.WALKING
# 1   2 WALKING_UPSTAIRS
# 2 3 WALKING_DOWNSTAIRS
# 3            4 SITTING
# 4           5 STANDING
# 5             6 LAYING
# Subject file's range is from 1 to 30

# Unique values of Activities and Subjects are the same with tidy_data.txt
# > tidy <- read.csv("tidy_file.txt")
# > unique(tidy[,1])
# [1] LAYING             SITTING            STANDING           WALKING           
# [5] WALKING_DOWNSTAIRS WALKING_UPSTAIRS  
# 6 Levels: LAYING SITTING STANDING WALKING ... WALKING_UPSTAIRS
# > unique(tidy[,2])
#  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
# [26] 26 27 2ck 8 29 30

# 2.) Check number of rows : There are 6 Activities and 30 Subjects, 6*30 is 180,
#     same number with number of rows in tidy_data.txt.

# To know the row count, install "R.utils".
# > install.packages("R.utils")
# > library("R.utils")

# > countLines('tidy_file.txt')  #number of lines including header
# [1] 181
# attr(,"lastLineHasNewline")
# [1] TRUE
# > tail(tidy, 1)    # Another option is View(tidy)
#            activity subject tBodyAcc_mean_X tBodyAcc_mean_Y
#180 WALKING_UPSTAIRS      30         0.2714156       -0.02533117
#    tBodyAcc_mean_Z tBodyAcc_std_X tBodyAcc_std_Y tBodyAcc_std_Z
# > unique(tidy[,1:2])
#               activity subject
# 1               LAYING       1	...
# 179 WALKING_DOWNSTAIRS      30
# 180   WALKING_UPSTAIRS      30


# 3.) Check number of columns : There are  66 measurements on the mean and standard deviation, 
#        plus activity and subject is 68, same number of columns as tidy_data.txt
# > MeanStd <- read.table("./UCI HAR Dataset/features.txt")
# > GetMeanStd <- features[grep("(mean|std)\\(", features[,2]),]
# > GetMeanStd   # This will list 66 mean and std dev features
# > length(tidy)
# [1] 68