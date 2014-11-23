# run_analysis.R
# Coursera Course - Getting and Cleaning Data (getdata-009)
# Final course project
# Submitted by:
# Werner Colangelo
# wernercolangelo@gmail.com

# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
# The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on
# a series of yes/no questions related to the project. You will be required to submit:
# 1) a tidy data set as described below,
# 2) a link to a Github repository with your script for performing the analysis, and
# 3) a code book that describes the variables, the data, and any transformations or work that you performed
# to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts.
# This repo explains how all of the scripts work and how they are connected.  

# One of the most exciting areas in all of data science right now is wearable computing - see for example
# this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced
# algorithms to attract new users. The data linked to from the course website represent data collected
# from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the
# site where the data was obtained: 

# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# Here are the data for the project: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# You should create one R script called run_analysis.R that does the following. 
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.

# Clear objects from Memory
rm(list=ls())
# Clear Console:
cat("\014")

# 1. Merge the training and the test sets to create one data set.

# set working directory to the location where the UCI HAR Dataset was unzipped
# setwd("C:/Users/werner/Dropbox/Programming/Coursera/DataScience_JH_specialization/3_Getting_and_Cleaning_Data/Project/Data")
setwd("C:/Users/werner/Dropbox/Programming/Coursera/DataScience_JH_specialization/3_Getting_and_Cleaning_Data/Project/SampleCode2/Data")

# Read in the data from files
featuresDF     = read.table('./features.txt',header=FALSE); # dim 561*2
dim(featuresDF)
activityTypeDF = read.table('./activity_labels.txt',header=FALSE); # dim 6*2
dim(activityTypeDF)
subjectTrainDF = read.table('./train/subject_train.txt',header=FALSE); # dim 7352*1
dim(subjectTrainDF)
xTrainDF       = read.table('./train/x_train.txt',header=FALSE); # dim 7352*561
dim(xTrainDF)
yTrainDF       = read.table('./train/y_train.txt',header=FALSE); # dim 7352*1
dim(yTrainDF)

# Assign column names to the data imported above
colnames(activityTypeDF)  = c('activityId','activityTypeDF');
colnames(subjectTrainDF)  = "subjectId";
colnames(xTrainDF)        = featuresDF[,2]; 
colnames(yTrainDF)        = "activityId";

# Create the final training set by merging yTrainDF, subjectTrainDF, and xTrainDF
trainingDataDF = cbind(yTrainDF,subjectTrainDF,xTrainDF);

# Read in the test data
subjectTestDF = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt
xTestDF       = read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
yTestDF       = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt

# Assign column names to the test data imported above
colnames(subjectTestDF) = "subjectId";
colnames(xTestDF)       = featuresDF[,2]; 
colnames(yTestDF)       = "activityId";


# Create the final test set by merging the xTestDF, yTestDF and subjectTestDF data
testDataDF = cbind(yTestDF,subjectTestDF,xTestDF);


# Combine training and test data to create a final data set
finalDataDF = rbind(trainingDataDF,testDataDF);

# Create a vector for the column names from the finalDataDF, which will be used
# to select the desired mean() & stddev() columns
colNames  = colnames(finalDataDF); 

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# Subset finalDataDF table based on the logicalVector to keep only desired columns
finalDataDF = finalDataDF[logicalVector==TRUE];

# 3. Use descriptive activity names to name the activities in the data set

# Merge the finalDataDF set with the acitivityType table to include descriptive activity names
finalDataDF = merge(finalDataDF,activityTypeDF,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames  = colnames(finalDataDF); 

# 4. Appropriately label the data set with descriptive activity names. 

# Cleaning up the variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Reassigning the new descriptive column names to the finalDataDF set
colnames(finalDataDF) = colNames;

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Create a new table, finalDataDFNoactivityTypeDF without the activityTypeDF column
finalDataDFNoactivityTypeDF  = finalDataDF[,names(finalDataDF) != 'activityTypeDF'];

# Summarizing the finalDataDFNoactivityTypeDF table to include just the mean of each variable for each activity and each subject
tidyDataDF    = aggregate(finalDataDFNoactivityTypeDF[,names(finalDataDFNoactivityTypeDF) != c('activityId','subjectId')],by=list(activityId=finalDataDFNoactivityTypeDF$activityId,subjectId = finalDataDFNoactivityTypeDF$subjectId),mean);

# Merging the tidyDataDF with activityTypeDF to include descriptive acitvity names
tidyDataDF    = merge(tidyDataDF,activityTypeDF,by='activityId',all.x=TRUE);

# Export the tidyDataDF set 
write.table(tidyDataDF, './tidyData.txt',row.names=TRUE,sep='\t');
