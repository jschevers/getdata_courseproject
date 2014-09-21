## Coursera Getting and Cleaning Data, Course project
## more info at: 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## download and unzip data into working directory, 
## "UCI HAR Dataset" will be created as subdirectory in the workingdirectory
zipfile="Dataset.zip"
if (!file.exists(zipfile)) {                   
  url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url,zipfile,method="auto")
}
if (!file.exists("./UCI HAR Dataset")) {
  unzip(zipfile)
  Sys.time() #"2014-09-17 20:54:08 CEST"
}

## 1 Merges the training and the test sets to create one data set.             

## read testdata 
subject_test=read.table("./UCI HAR Dataset/test/subject_test.txt")    # subjects
activities_test=read.table("./UCI HAR Dataset/test/y_test.txt")       # activities
test_data=read.table("./UCI HAR Dataset/test/X_test.txt")             # test-data
test_data=cbind(subject_test,activities_test,test_data)               # bind subject and activities with data

## read trainingdata
subject_train=read.table("./UCI HAR Dataset/train/subject_train.txt") # subjects
activities_train=read.table("./UCI HAR Dataset/train/y_train.txt")    # activities
train_data=read.table("./UCI HAR Dataset/train/X_train.txt")          # training data
train_data=cbind(subject_train,activities_train,train_data)           # bind subject and activities with data

## (row)bind test-and training set 
total_data=rbind(test_data,train_data)

#remove files no longer needed
rm(test_data,subject_test,activities_test,train_data,subject_train,activities_train) 


##2. Extracts only the measurements on the mean and standard deviation for each measurement. 

## read features, these are the (data)columnnames 
feat=read.table("./UCI HAR Dataset/features.txt",sep=" ") 
findex=grep("mean()|std()",feat[,2])         # search for "mean()" and "std()", see README.md
colindex=c(c(1,2),findex+2)                  # first two columns in total_data are subject and activities 
dat=total_data[,colindex]                    # creata dataset with columns we need
rm(total_data)                               # remove the big dataset, don't need this anamore


# 4 Appropriately labels the data set with descriptive variable names. 
colnames=feat[findex,2]               # features are in second column
# remove '(',')','-' en set to lowercase
colnames=gsub("\\(","",colnames)
colnames=gsub("\\)","",colnames)
colnames=gsub("-","",colnames)
colnames=tolower(colnames)

## set the columnnames, first two columns in total_data are subjects and activities,  
names(dat)=c("subject","activity",colnames)

## 3 Uses descriptive activity names to name the activities in the data set
# read activity_labels.txt
actlabels=read.table("./UCI HAR Dataset/activity_labels.txt")
names(actlabels)=c("activity","activitylabel")
dat=merge(dat,actlabels,by="activity")  


## 5 From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject
TD=aggregate(dat[,3:81],  list(dat$subject,dat$activitylabel),FUN= mean)
nwename1=names(TD)[1:2]=c("subject","activitylabel")
nwename2=names(TD)[3:length(TD)]
nwename2=paste("avg",nwename2,sep="")
names(TD)=c(nwename1,nwename2)

# write the data to disk for upload
write.table(TD,file="./meanofmeasures.txt",row.name=FALSE)

