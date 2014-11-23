Coursera Course - Getting and Cleaning Data (getdata-009)
* Final course project
* Submitted by: Werner Colangelo
* wernercolangelo@gmail.com

Getting and Cleaning Data Course Project CodeBook
=================================================
This file describes the data, variables and transformations performed to clean up the data.
* Data location : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      
* Data files: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* The run_analysis.R script performs the following steps to clean the data:
 1. Read features.txt and activity_labels.txt from the current working directory and store them in featuresDF and activityTypeDF respectively.
 2. Read x_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in *xtrainDF*, *ytrainDF* and *subjectTrainDF* variables respectively.
 3. Assign column names to the train data imported in 1) and 2)
 4. Create the final training set by merging yTrainDF, subjectTrainDF, and xTrainDF.
 5. Read subject_test.txt, x_test.txt and y_test.txt from the "./data/train" folder and store them in *subjectTestDF*, *xtestDF* and *ytestDF* respectively.
 6. Assign column names to the test data imported in 5)
 7. Create the final test set by merging the xTestDF, yTestDF and subjectTestDF data
 8. Combine training and test data to create a final data set
 9. Create a vector for the column names from the finalDataDF, which will be used to select the desired mean() & stddev() columns.
 10. Extract only the measurements on the mean and standard deviation for each measurement. by creating a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others
 11. Subset finalDataDF table based on the logicalVector to keep only desired columns.
 12. Use descriptive activity names to name the activities in the data set by merging the finalDataDF set with the acitivityType table to include descriptive activity names.
 13. Update the colNames vector to include the new column names after merge.
 14. Appropriately label the data set with descriptive activity names.
 15. Reassigng the new descriptive column names to the finalDataDF set.
 16. Create a second, independent tidy data set with the average of each variable for each activity and each subject by creating a new table, finalDataDFNoactivityTypeDF without the activityTypeDF column.
 17. Summarize the finalDataDFNoactivityTypeDF table to include just the mean of each variable for each activity and each subject and merge the tidyDataDF with activityTypeDF to include descriptive acitvity names.
 18. Lastly, export the tidyDataDF set.
