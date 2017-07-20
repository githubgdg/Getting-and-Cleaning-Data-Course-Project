# CODE BOOK

This is a code book that describes the data, variables and summaries calculated, along with units, 
and any other relevant information.


## Data Source :
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## Data Set Information : 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, 
LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and 
gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly 
partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 
30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then 
sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor 
acceleration signal, which has gravitational and body motion components, was separated using a Butterworth 
low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low 
frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector 
of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' 
for more details. 

**For each record it is provided:**

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

**The dataset includes the following files:**

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

**The following files are available for the train and test data. Their descriptions are equivalent.**

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. 
  Its range is from 1 to 30. 
- 'train/subject_test.txt' : Its range is from 2 to 24.


## Folders:

   1. In your working directory, "get_clean_project" will be created.  This will contain all unzipped files
      from the zip files downloaded from the url data source.
   2. "get_clean_project" folder will also contain the file to be created by the R script.
   3. "UCI HAR Dataset" will be created in "get_clean_project" when zip file is unzipped.


## Variables :

- fileUrl : stores source file's url.
- features : data set from features.txt.
- x_test : data set from X_test.txt, test set.
- x_train : data set from X_train.txt, training set.
- x : Merged data of test and training sets, by row.
- mean_std_Features : gets features for mean and standard deviation.
- mean_std : gets Merged data set's (x) measurements on mean and standard deviation.
- y_test : data set from y_test.txt, test labels.
- y_train : data set from y_train.txt, training labels.
- y : Merged data by row of test and training labels, initial value is number, final value is activity name.
- activity_names : data set from activity_labels.txt.
- x_with_names : Merged data of test and training sets with activity names
- mean_std_with_names : Merged data set's (x) measurements on mean and standard deviationn with activity names
- subject_test : data set from subject_test.txt
- subject_train : data set from subject_train.txt
- subject : Merged data of test and training subjects, by row.
- average_by : average of each variable for each activity and each subject


## Packages/Libraries :

1. data.table
2. reshape2


## Transformations :

1. Merges the training and the test sets to create one data set.
      - Load both test and train sets data, X_test.txt and X_train.txt.
      - Load the features data to use as column names, features.txt.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
      - Get features for mean and standard deviation only.
      - Get data set in step 1 the measurements on mean and standard deviation.

3. Uses descriptive activity names to name the activities in the data set.
      - Load the activity labels data, activity_labels.txt.
      - Replace Activity ID or Code with Activity Name or Label.

4. Appropriately labels the data set with descriptive variable names.
      - Use names() and gsub() to change variable or column name.  For this script, "." and "..."
        are replaced by "_".

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
   for each activity and each subject.
      - Load the subjects data, subject_test.txt.
      - Get average of each variable for each activity and each subject by using aggregate().
      - Create a file for the average data set.


## Output :

**File Data Set :**  ***tidy_file.txt***

All the values are means, aggregated over 30 subjects and 6 activities, resulting into a data set with 180 rows 
and 68 columns.
