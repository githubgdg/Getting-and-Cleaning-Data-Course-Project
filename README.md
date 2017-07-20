# Getting-and-Cleaning-Data-Course-Project
This repository contains files for Peer-graded Assignment: Getting and Cleaning Data Course Project.

# Files in this Repository :

   1. README.md : This file you are currently reading.
   2. CodeBook.md : Describes variables, the data, and any transformations or work that you performed to clean up the data.
                    This file also explains what is in run_analysis.R.
   3. run_analysis.R : This file is the actual R code.  After the code, steps on how to run this R script and test tidy file
                       is listed.

# Script Requirement :

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis.

Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following:

   1. Merges the training and the test sets to create one data set.
   2. Extracts only the measurements on the mean and standard deviation for each measurement.
   3. Uses descriptive activity names to name the activities in the data set
   4. Appropriately labels the data set with descriptive variable names.
   5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
      variable for each activity and each subject.

# Dependencies:
   run_analysis.R uses libraries data.table and reshape2

# To run run_analysis.R in R :
   In R window, click on File menu, choose "Source R COde", then choose run_analysis.R from your machine or use source().
   Choose Secure CRAN Mirrors when asked.
   
# File Name from requirement #5 :
   tidy_data.txt
