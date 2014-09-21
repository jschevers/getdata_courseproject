## Course Project Getting and Cleaning Data
background: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

https://github.com/jschevers/getdata_courseproject.git included files:
*README.md,      this file, exlpains how run_analysis.R works
*CodeBook.md,    discription of data transformations
*run_analysis.R, downloads and unzips data. Read en trandforms data and creats neccecery files.

## Assignment: 
You should create one R script called run_analysis.R that does the following. 

 *1   Merges the training and the test sets to create one data set.
 *2   Extracts only the measurements on the mean and standard deviation for each measurement. 
 *3   Uses descriptive activity names to name the activities in the data set
 *4   Appropriately labels the data set with descriptive variable names. 
 *5   From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## run_analysis.R
This script will download and unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
In the working directory, the subdir "UCI HAR Dataset" will be created with files and subfiles

## Assignment 1:
The files in the subdir "test" subject_test.txt (subjects), y_test.txt (activities) and X_test.txt (measurments) will be read into R (with command 
"read.table", defailt settings) and cbinded. Same for the "train" subdir

After that the two (test- and train datasets) wil be rowbinded to create one dataset. First column is the subjectvariavle, the second the activities, the following (the measurments)
as describes in features_info.txt. 

## Assignment 2:
features.txt will be read, the second column contains the columnames for the measurments. Only the measurements on the mean and standard deviation for each measurement 
should be used. This are the names with "mean()" or "std()" in it. Names with only "mean" are not avarages of measurments: variables with "meanFreq" are Weighted average 
of the frequency components to obtain a mean frequency, variables with "gravityMean" are angles between two vectors. So for the resulting dataset, 
only use variables with "mean()" and "std()". The grep command is used for the search. This will return the indexes of the needed variables. Because the first two columns in the
dataset are the subject and activities, the indexes are raised by 2.   
(The command grep("[mM]ean[^\\(]",feat[,2],value=TRUE) will provide 20 variables with "mean" in it without "mean()")

## Assignment 4:
This before Assignment 3, because it's also about the variable names. To clean these I removed (with gsub) the tokens '(',')','-' en set the names to lowercase.
   
## Assignment 3:
The file activity_labels.txt contains the activitycodes with the descriptive names. With read.tabel (default settings) this file is read in and
merged with the data. Column 82 will be created and called "activitylabel". 

## Assignment 5:
With the command "aggregate" the mean of the measurments (cols 3 to 81) are calculated by "subject" and "activitylabel" ("activity" will not be used). 
The resulting dataset will be given columnnames "subject" and "activitylabel" (the grouping variables) and the measurment-names with "avg" in front of it.  
With the command write.table it is exported into the working-directory: meanofmeasures.tx. This is the file for the upload.
